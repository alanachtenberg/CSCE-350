
.data
mesg: .asciiz "Enter the value for register s1:"

.text

main:

la	$a0, mesg		# Load effective address(mesg) to $a0

addi	$v0, $0, 4	# Load constant 4 to reg v0

syscall		# Switch into the "kernel" to print 'mesg' out


addi	$v0, $0, 5	# reg v0 = 5

syscall

add	$s0, $v0, $0

li $v0, 10 #exit system call

syscall
