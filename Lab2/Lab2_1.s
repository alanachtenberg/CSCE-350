#Alan Achtenberg
#CSCE-350
#Lab2-part1


main:
	li $s1, 3 #program argument
	
	add $t0, $s1, $0
	add $t1, $t0, $t0
	add $t2, $t1, $t1
	add $t3, $t2, $t2
	add $t4, $t3, $t3
	add $t5, $t4, $t4
	add $t6, $t5, $t5
	add $t7, $t6, $t6
	
	li $v0, 10
	syscall #system exit call
	
	