
.data
B:	.word 722		# B[0]
	.word 21 		# B[1]
	.word 4 		# B[2]
	.word 89		# B[3]
	.word 16384		# B[4]
	.word 350		# B[5]
	.word 6046		# B[6]
	.word 897		# B[7]
	.word 1201		# B[8]
	.word 0			# B[9]
	.word 904		# B[10]
	.word 897		# B[11]
	.word 4805		# B[12]
	.word 679		# B[13]
	.word 7			# B[14]
SZ:	.word 15

.text

main:
	#implement bubblesort
	
	li $t0 ,0 #i
	li $t1 ,0 #j
	li $t2 ,4 #B i
	li $t3 , 0 #B j
	lw $t4, SZ #size
	la $t5, B #address of B
	#addressing trick to get i and j in terms of 4bytes
	#mult size by 4 and then increment i and j by 4 instead of 
	
	mult $t4,$t2
	mflo $t4
	
	Loop1: beq $t0,$t4 End1
		addi $t1, $t0, 4 #j=i+4
		Loop2:beq $t1,$t4 End2
			add $t0, $t0, $t5 #add address of B to make absolute address
			add $t1, $t1, $t5
			lw $t2,0($t0) #B[i]
			lw $t3,0($t1) #B[j]
			blt $t2,$t3, else 
				sw $t3, 0($t0)
				sw $t2, 0($t1)
			else:
			sub $t0, $t0, $t5 #remove address of B to return i and j
			sub $t1, $t1, $t5
		addi $t1, $t1, 4 #j=i+4
		j Loop2
		End2:
		addi $t0, $t0, 4
		j Loop1
	End1:
	
	li $v0, 10 #exit system call

	syscall