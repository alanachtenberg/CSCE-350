.data
	stack_err_mesg: .asciiz "Error: item cannot be popped when the stack is empty\n"
	postfix_err_mesg: .asciiz "Error: Expression not formatted properly"
	postfix_expression_test: .asciiz "84-4/"
	plus: .asciiz "+"
	minus: .asciiz "-"
	multiply: .asciiz "*"
	divide: .asciiz "/"
	stack_buf: .word 0 #buffer to store items passed to and from user stack
	TOS: .word 0 #top of stack	   initially null
	FL: 	.word M 			# will be stores in $s0
	M: 		.space 4096
.text
.globl main

main:
	jal 	mem_init
	la 		$a0, postfix_expression_test
	jal 	evaluate_postfix_expression

	move 	$a0 ,$v0
	li 		$v0, 1
	syscall
	
	li		$v0, 10
	syscall


# memory manager
#-------------------------------------------------------------------------------
# void mem_init()
mem_init:
	la 		$t0, FL
	lw		$t0, 0($t0)
	li 		$t1, 0
	li 		$t2, 4088

mem_init_loop:
	bge 	$t1, $t2, init_exit
	addi 	$t3, $t0, 8
	sw		$t3, 4($t0)
	addi 	$t0, $t0, 8
	addi	$t1, $t1, 8
	j 		mem_init_loop
init_exit:
	jr		$ra

	
# block_t* mem_alloc()
mem_alloc:
	la 		$t0, FL #get FL pointer
	bne		$t0, $0, alloc_next
	addi 	$v0, $0, -1				# exception returns -1
	j 		alloc_exit
alloc_next:
	lw		$v0, ($t0) #load first block address
	lw 		$t1, 4($v0) #load next pointer t1
	sw 		$t1, ($t0) #store t1 next pointer
	sw		$0, 4($v0) #overwrite old pointer
alloc_exit:
	jr		$ra

	
# void mem_dealloc(block_t *p)
mem_dealloc:
	add 	$t0, $a0, $0
	bne 	$t0, $0, dealloc_next
	addi 	$t0, $0, -1
	j 		dealloc_exit
dealloc_next:
	la 		$t1, FL
	lw		$t2,($t1) #update next pointer to FL pointer
	sw 		$t2, 4($t0)
	sw		$0,	 ($t0) #clear mem on old data
	sw 		$t0, 0($t1) #update FL pointer to a0
dealloc_exit:
	jr		$ra
	
	
#a0 pointer to memory, a1 value of int to set
# void set_data_int(block_t* item, int value)
set_data_int:
	sw 		$a1, ($a0)
	jr 		$ra
	
#a0 pointer to memory
# void print_data(block_t* item)
print_data:
	li 		$v0, 1
	lw 		$a0, ($a0)
	syscall
	jr 		$ra #jump register

	
# Stack 
#-------------------------------------------------------------------------------		
#a0 =data_t* pushes data onto stack
stack_push:
	addi 	$sp, -8
	sw 		$ra, ($sp) #save variables
	sw 		$a0, 4($sp)
	
	jal 	mem_alloc #allocate 8 bytes
	add 	$t0, $v0, $0 #move return pointer to t0
	lw 		$ra, ($sp) #reload variables from stack
	lw 		$a0, 4($sp)
	
	#store new data
	lw 		$t1, ($a0) #get int from pointer
	sw 		$t1, ($t0) #store int in new block_t
	la 		$t1, TOS #TOS address

	#update stack
	lw 		$t2, ($t1) #t2 is block_t pointer
	sw 		$t2, 4($t0) # store pointer to struct [4 byte data,4 byte next pointer] 
	sw 		$t0, ($t1) #point tos to new block

	addi 	$sp, 8 #return stack pointer to origin
	jr 		$ra
		
#v0 is returned data
stack_pop:
	addi 	$sp, -4 #save return address
	sw 		$ra, ($sp)
	
	la 		$t0, TOS 
	lw 		$t1, ($t0) 
	beq 	$t1, $0, exception #check for null
	
	lw		$t3, ($t1) #get int from pointer
	la		$v0, stack_buf
	sw 		$t3, ($v0) #save data value
	
	lw 		$t2, 4($t1) #load next pointer
	sw 		$t2, ($t0) #store next pointer in TOS
	
	add 	$a0, $t1, $0 #move address of old block to deallocate
	jal 	mem_dealloc
	
	la		$v0, stack_buf
	lw 		$ra, ($sp)
	addi 	$sp, 4
	jr 		$ra

exception:
	la 		$a0, stack_err_mesg
	li 		$v0, 4
	syscall #print error mesg

	lw 		$ra, ($sp)
	addi 	$sp, 4
	jr 		$ra

# Postfix expression evaluator
#-------------------------------------------------------------------------------
# int evaluate_postfix_expression(string* s)
evaluate_postfix_expression:
	addi 	$sp, -4 			#save return address
	sw 		$ra, ($sp)

	add 	$t7, $a0, $0
	lb		$t0, 0($t7)
postfix_loop:
	lb		$t0, 0($t7)
	beq 	$t0, $0, exit 		# if at end of string, exit
	
# check if string is operand
	la 		$t1, plus
	lb 		$t1, 0($t1) #get value ascii value of plus
	beq 	$t0, $t1, op_plus 

	la 		$t1, minus
	lb 		$t1, 0($t1) #switched to lb because char minus is one byte not 4
	beq 	$t0, $t1, op_minus

	la 		$t1, multiply
	lb 		$t1, 0($t1)
	beq 	$t0, $t1, op_multiply

	la 		$t1, divide
	lb 		$t1, 0($t1)
	beq 	$t0, $t1, op_divide

#if its not operand, then it must be a number. If it isn't, throw an exception
	li 		$t1, 48
	blt 	$t0, $t1, postfix_exception

	li 		$t1, 57
	bgt		$t0, $t1, postfix_exception 

	addi 	$t0, $t0, -48
	
	la		$a0, stack_buf #use buffer because stack takes in pointer to data_t, not data_t 
	sw		$t0, ($a0)
	jal 	stack_push

	addi 	$t7, $t7, 1 	# increment the string pointer
	j		postfix_loop

op_plus:
	jal 	stack_pop
	addi    $sp, -4
	lw 		$t4 ,($v0)	#save return value
	sw		$t4, ($sp)
	
	jal 	stack_pop
	lw		$t4, ($sp)
	addi	$sp, 4
	lw 		$t3 ,($v0)
	
	add 	$t3, $t3, $t4 
	la 		$a0, stack_buf
	sw		$t3, ($a0)
	jal 	stack_push
	addi 	$t7, $t7, 1
	j 		postfix_loop

op_minus:
	jal 	stack_pop
	lw 		$t4 ,($v0)
	addi    $sp, -4
	sw		$t4, ($sp)
	
	jal 	stack_pop
	lw		$t4, ($sp)
	addi	$sp, 4
	lw 		$t3 ,($v0)
	
	
	sub 	$t3, $t3, $t4 #subtract operation t3-t4 order matters!
	la		$a0, stack_buf
	sw		$t3, ($a0)
	jal		stack_push
	addi 	$t7, $t7, 1
	j 		postfix_loop

op_multiply:
	jal 	stack_pop
	lw 		$t4 ,($v0)
	addi    $sp, -4
	sw		$t4, ($sp)
	
	jal 	stack_pop
	lw		$t4, ($sp)
	addi	$sp, 4
	lw 		$t3 ,($v0)
	
	mul 	$t3, $t3, $t4 
	la		$a0, stack_buf
	sw		$t3, ($a0)
	jal		stack_push
	addi 	$t7, $t7, 1
	j 		postfix_loop

op_divide:
	jal 	stack_pop
	lw 		$t4 ,($v0)
	addi    $sp, -4
	sw		$t4, ($sp)
	
	jal 	stack_pop
	lw		$t4, ($sp)
	addi	$sp, 4
	lw 		$t3 ,($v0)
	
	div 	$t3, $t3, $t4 #Order matters! stack is first in last out
	la 		$a0, stack_buf
	sw		$t3, ($a0)
	jal		stack_push
	addi 	$t7, $t7, 1
	j 		postfix_loop

postfix_exception:
	la 		$a0, postfix_err_mesg
	li 		$v0, 4
	syscall 		#print error mesg

	lw 		$ra, ($sp)
	addi 	$sp, 4
	jr 		$ra

exit:
	jal 	stack_pop
	lw 		$v0, ($v0) #get final answer from buffer
	lw 		$ra, ($sp)
	addi 	$sp, 4
	jr 		$ra