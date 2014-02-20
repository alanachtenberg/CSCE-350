#Alan Achtenberg
#CSCE 350-502
#LAB 4
#part 1
        .data

		msg1:   .asciiz  "The sum is "
NL:     .asciiz  "\n"
A:      .word    3
B:      .word    10
C:      .word    20

        .text
        .globl  main            # main is a global symbol

main:
		la $t0, A
		la $t1, B
		la $t2, C
        lw $a0 ,0($t0)
		lw $a1 ,0($t1)
		lw $a2 ,0($t2)
	
        jal Sum #jump to sum and link address..(store current address in ra)
		
		add $t0, $v0, $0 #save function result



        li       $v0, 4
        la       $a0, msg1
        syscall                 # print "The sum is "

        li       $v0, 1
        ## FIX move instruction
        move     $a0, $t0     # move sum to $a0
        syscall                 # print the sum

        li       $v0, 4
        la       $a0, NL
        syscall                 # print newline

        li       $v0, 10
        syscall                 # exit

Sum:	add $v0, $a0, $a1
		add $v0, $v0, $a2
		jr $ra #jump register
