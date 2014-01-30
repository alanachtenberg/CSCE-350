#Alan Achtenberg
#CSCE-350
#Lab2-part2

.data 0x10008000			# data segment start (assembler directive)

B:	.word 300			# B[0]

	.word 200			# B[1]

	.word 100			# B[2]

	.word 0				# B[3]

i:	.word 3

.text 					# code segment start (assembler directive)

main:	la	$t1,	B		# load the address of B[0] (&(B[0]) == B) into register $t1

	lw	$t0,	0($t1)		# load value of B[0] into register $t0
	addi $t2,$t0,0

	lw $t0, 4($t1)
	add $t2,$t0,$t2
	
	lw $t0, 8($t1)
	add $t2, $t0, $t2
	lw $t0, i
	addi $t3, $0, 4 
	mult $t0, $t3
	mflo $t0
	add $t0, $t1, $t0
    sw $t2, 0($t0)
	
	addi	$v0,	$0,	10	# `exit MIPS program' syscall

	syscall