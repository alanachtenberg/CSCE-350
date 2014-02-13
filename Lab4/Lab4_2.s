.data

.align	2				# Request alignment on word (4 byte) boundary



## 4x4 Matrix Declaration ##

A0:	.word 41, 42, 43, 44		# Declare and initialize 1st Row of A

A1:	.word 55, 56, 57, 58		# Declare and initialize 2nd Row of A

A2:	.word 19, 10, 11, 12		# Declare and initialize 3rd Row of A

A3:	.word 23, 24, 25, 26		# Declare and initialize 4th Row of A

A:	.word A0, A1, A2, A3		# Declare and initialize the pointer to the rows

T0:	.word  0,  0,  0,  0		# Declare and initialize 1st Row of T

T1:	.word  0,  0,  0,  0		# Declare and initialize 2nd Row of T

T2:	.word  0,  0,  0,  0		# Declare and initialize 3rd Row of T

T3:	.word  0,  0,  0,  0		# Declare and initialize 4th Row of T

T:	.word T0, T1, T2, T3		# Declare and initialize the pointer to the rows



NUMROWS_A:	.word	4		# the number of rows

NUMCOLS_A:	.word	4		# the number of columns

NUMROWS_T:	.word	4		# the number of rows

NUMCOLS_T:	.word	4		# the number of columns

.text

.globl main

main:
	la $a0, A
	la $a1, T
	la $a2, NUMROWS_A
	la $a3, NUMCOLS_A
	lw $a2, ($a2)
	lw $a3, ($a3)
	
	jal mat_transpose
	

	

    li       $v0, 10
    syscall                 # exit
	
	
	mat_transpose:
		li $t6, 0 #i
		li $t7, 0 #j
		

		Loop_i:
			beq $t6, $a2 end_i
			Loop_j:
				beq $t7, $a3 end_j
				
				sll	$t2,	$t6,	2	# Shift left twice (same as i * 4)
				
				add	$t2,	$t2,	$a0	# Address of pointer A[i]

				lw	$t3,	($t2)		# Get address of an array A[i] and put it into register $t3

				sll	$t4,	$t7,	2	# Shift left twice (same as j * 4)

				add	$t4,	$t3,	$t4	# Address of A[i][j]

				lw	$t0,	($t4)		# Load value of A[i][j]
				
				
				
				sll	$t2,	$t7,	2	# Shift left twice (same as j * 4)
				
				add	$t2,	$t2,	$a1	# Address of pointer T[j]
				
				lw	$t3,	($t2)		# Get address of an array T[j] and put it into register $t3
				
				sll	$t4,	$t6,	2	# Shift left twice (same as i * 4)

				add	$t4,	$t3,	$t4	# Address of T[j][i]
				
				sw $t0 ,($t4) #store A[i][j] in T[j][i]
				
				addi $t7, 1 #increment j
				j Loop_j
				end_j:
			addi $t6, 1 #increment i
			j Loop_i
		end_i:
	
	jr $ra #end function


