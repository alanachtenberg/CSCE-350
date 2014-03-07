.data
	err_mesg: .asciiz "Error the stack can not be popped when the stack is empty\n"
		plus: .asciiz "+"
		minus: .asciiz "-"
		multiply: .asciiz "*"
		divide: .asciiz "/"
		TOS: .word 0 #top of stack	   initially null
		test_1: .word 1
		test_2: .word 2
		test_3: .word 3
		test_4: .word 4
		test_5: .word 5
		test_6: .word 6
FL: 	.word M 			# will be stores in $s0
M: 		.space 4096
.text
.globl main

main:
	jal 	mem_init
	
	
	
		
		la $a0, test_1
		jal stack_push #step here
		la $a0, test_2
		jal stack_push #step here
		la $a0, test_3
		jal stack_push #step here
		jal stack_pop
		move $a0 ,$v0
		li $v0, 1
		syscall
		
		la $a0, test_4
		jal stack_push #step here
		la $a0, test_5
		jal stack_push #step here
		la $a0, test_6
		jal stack_push #step here
		
		jal stack_pop
		move $a0 ,$v0
		li $v0, 1
		syscall
		jal stack_pop
		move $a0 ,$v0
		li $v0, 1
		syscall
		jal stack_pop
		move $a0 ,$v0
		li $v0, 1
		syscall
		jal stack_pop
		move $a0 ,$v0
		li $v0, 1
		syscall
		jal stack_pop
		move $a0 ,$v0
		li $v0, 1
		syscall
		
	
	li		$v0, 10
	syscall


# memory manager
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
	
	sw 		$t0, 0($t1) #update FL pointer to a0
dealloc_exit:
	jr		$ra
	
#a0 pointer to memory, a1 value of int to set
	set_data_int:
		sw $a1, ($a0)
		jr $ra
		
		#a0 pointer to memory
		print_data:
			li $v0, 1
			lw $a0, ($a0)
			syscall
		jr $ra #jump register
		
		#a0 =data_t* pushes data onto stack
		stack_push:
			addi $sp, -8
			sw $ra, ($sp) #save variables
			sw $a0, 4($sp)
			
			jal mem_alloc #allocate 8 bytes
			add $t0, $v0, $0 #move return pointer to t0
			lw $ra, ($sp) #reload variables from stack
			lw $a0, 4($sp)
			
			#store new data
			lw $t1, ($a0) #get int from pointer
			sw $t1, ($t0) #store int in new block_t
			
			la $t1, TOS #TOS address
			#update stack
			lw $t2, ($t1) #t2 is block_t pointer
			sw $t2, 4($t0) # store pointer to struct [4 byte data,4 byte next pointer] 
			sw $t0, ($t1) #point tos to new block

			addi $sp, 8 #return stack pointer to origin
		jr $ra
		
		#v0 is returned data
		stack_pop:
			addi $sp, -4 #save return address
			sw $ra, ($sp)
			
			la $t0, TOS 
			lw $t1, ($t0) 
			beq $t1, $0, exception #check for null
			lw $v0, ($t1) #load data value
			lw $t2, 4($t1) #load next pointer
			sw $t2, ($t0) #store next pointer in TOS
			add $a0, $t1, $0 #move address of old block to deallocate
			jal mem_dealloc
			
			lw $ra, ($sp)
			addi $sp, 4
		jr $ra
		
			exception:
			la $a0, err_mesg
			li $v0, 4
			syscall #print error mesg
			lw $ra, ($sp)
			addi $sp, 4
		jr $ra