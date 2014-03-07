#Alan Achtenberg
#CSCE 350-502
#Project 1
#stack structure



	.data
		err_mesg: .asciiz "Error the stack can not be popped when the stack is empty\n"
		plus: .asciiz "+"
		minus: .asciiz "-"
		multiply: .asciiz "*"
		divide: .asciiz "/"
		TOS: .word 0 #top of stack	   initially null
		test_1: .word 5 
		test_2: .space 64 # dummy allocator return space 8 8byte blocks
    .text
        .globl  main            # main is a global symbol

main:	
		la $s0, test_2
		la $a0, test_1
		jal print_data
		
		la $a0, test_1
		li $a1, 2
		jal set_data_int
		jal print_data
		
		la $a0, test_1
		jal stack_push #step here
		la $a0, test_1
		
		jal stack_push #step here
		jal eval

        li       $v0, 10
        syscall                 # exit
		
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
		
		#
		eval:
			#lw $t1
			
		
		
		jr $ra
		
		
		mem_alloc:
			add $v0, $s0, $0
			addi $s0, 8 #dummy allocator function
			jr $ra
			
		mem_dealloc:
			sw $0, ($a0)
			sw $0, 4($a0)
			addi $s0, -8 #dummy allocator function
			jr $ra
			
		