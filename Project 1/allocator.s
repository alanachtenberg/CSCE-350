.data
FL: 	.word M 			# will be stores in $s0
M: 		.space 4096
.text
.globl main

main:
	jal 	mem_init
	
	jal 	mem_alloc
	li 		$t1, 1
	sw 		$t1, 0($v0)
	jal 	mem_alloc
	li 		$t1, 2
	sw 		$t1, 0($v0)
	jal		mem_alloc
	li 		$t1, 3
	sw 		$t1, 0($v0)
	jal 	mem_alloc
	li 		$t1, 4
	sw 		$t1, 0($v0)
	jal 	mem_alloc
	li 		$t1, 5
	sw 		$t1, 0($v0)
	jal		mem_alloc
	li 		$t1, 6
	sw 		$t1, 0($v0)
	
	move $a0, $v0
	jal 	mem_dealloc
	
	jal		mem_alloc
	li 		$t1, 7
	sw 		$t1, 0($v0)
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