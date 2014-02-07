#Alan Achtenberg
#CSCE 350
#LAB 3 part 1

.data
mesg: 	.asciiz "Input number to count bits\n"
mesg_0: .asciiz " has "
mesg_1: .asciiz " bits for 1"

.text

main:
	
	la	$a0, mesg		# Load effective address(mesg) to $a0
	addi	$v0, $0, 4	# Load constant 4 to reg v0
	syscall		# Switch into the "kernel" to print 'mesg' out
	addi	$v0, $0, 5	# system read
	syscall
	li $t2, 32 #counter for while loop
	li $t0, 0 #init to 0
	li $t3, 32 #constant
	#we will count number of 1's by adding all the individual bits

	Loop:
	srl $t1,$v0,$t2 #shift right by t2
	beq $t2,$0,End #if t2 is 0 end loop
	andi $t1, $t1, 1
	add $t0,$t0,$t1
	addi $t2,$t2,-1
	j Loop
	End:
	
	addi $a0, $v0,0
	addi	$v0, $0, 1
	syscall
	la $a0, mesg_0
	addi	$v0, $0, 4	# Load constant 4 to reg v0
	syscall		# Switch into the "kernel" to print 'mesg' out
	addi $a0, $t0, 0
	addi	$v0, $0, 1
	syscall
	la $a0, mesg_1
	addi	$v0, $0, 4	# Load constant 4 to reg v0
	syscall		# Switch into the "kernel" to print 'mesg' out
	
	
	
	


	li $v0, 10 #exit system call

	syscall