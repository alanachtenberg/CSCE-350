
.data
 mesg1: .asciiz "Input the nth fibonacci number you desire\n"
 mesg2: .asciiz " is the "
 mesg3: .asciiz "th fibonacci number"
.text
.globl main

main:
	la $a0, mesg1
	li $v0, 4
	syscall
    li       $v0, 5 #read int
    syscall	
	add $a0, $v0, $0 #store argument from system read
	add $s1, $v0, $0#save vaule for nicer printing
	jal fib
	
	add $a0, $v0, $0 #print result
	li $v0, 1
	syscall
	
	la $a0, mesg2
	li $v0, 4
	syscall
	
	add $a0, $s1, $0
	li $v0, 1
	syscall
	
	la $a0, mesg3
	li $v0, 4
	syscall
	
	
	li       $v0, 10
    syscall                 # exit
	


fib: 
	bgt $a0, 2, cont #if a0 is greater than 2 do recursion
	add $v0, $a0, $0 #base case when n is 0 or 1
	jr $ra
	
	cont:
		addi $sp, -12 
		sw $ra, ($sp) #save vaules
		sw $a0, 4($sp) 
		
		addi $a0, -1
		jal fib #function call for n-1
		sw $v0, 8($sp) #save result to stack
		lw $a0, 4($sp) #load n from stack
		
		addi $a0, -2 
		jal fib #function call for n-2
		lw $t0, 8($sp) #get result off stack
		add $v0, $v0, $t0 #
		
		lw $ra, 0($sp) # retrieve return address
		addi $sp, $sp, 12 #return stack to original
		jr $ra