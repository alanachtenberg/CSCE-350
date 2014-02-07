#Alan Achtenberg
#CSCE 350
#LAB 3 part 1

.data
mesg_0: .asciiz " is not a power of two"
mesg_1: .asciiz " is a power of two"

.text

main:

	li $t0, 256 #number to test if its a power of two

	addi $t1,$t0,-1 #subtract 1 to get inverted bits if t0 is power of 2
	and $t1,$t0,$t1 #and t0 and t0-1, preserve t0 for printing
	
	addi $a0,$t0, 0
	addi 	$v0, $0, 1 #print int
	syscall
	
	beq $t1, $0 ,Else
	la	$a0, mesg_0		# Load effective address(mesg_1) to $a0 
	j Endif
	Else:
	la	$a0, mesg_1
	Endif:
	
	
	addi	$v0, $0, 4	# Load constant 4 to reg v0
	syscall		# Switch into the "kernel" to print 'mesg' out



	li $v0, 10 #exit system call

	syscall