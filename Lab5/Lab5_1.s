

       .data
mesg:    .asciiz "Please input string to count\n"
mesg2:	.asciiz "produces strlen="
delim:     .asciiz  "" #null
buff:   .space  256 #256 byte buffer for string input

        .text
        .globl  main            # main is a global symbol

main:
		la $a0, mesg
		li $v0, 4
		syscall
		
		la $t0, delim
		la $a0, buff
		li $a1, 256
		li $v0, 8
		syscall #read string
		
		la $t0, delim
        lb $a1, 0($t0) #null in argument 1
		
	 					# strlen call format: a0=string, a1=delim char
        jal strlen 		#jump to sum and link address..(store current address in ra)
		add $t0, $v0, $0 #save function result


        li       $v0, 4
        la       $a0, buff
        syscall                
		la $a0, mesg2
		syscall

        li       $v0, 1
        move     $a0, $t0       # move result to $a0
        syscall             

        li       $v0, 4
        la       $a0, NL
        syscall                 # print newline

        li       $v0, 10
        syscall                 # exit

strlen:	
		li $v0, 0 #initialize to 0
		Loop:
		lb $t1, 0($a0) #load first byte
		beq $t1, $a1, end #a1 is delim character
		addi $v0, 1 #increment for every char that is not delim
		addi $a0, 1
		j Loop
		end:
		jr $ra #jump register
