#Alan Achtenberg
#CSCE 350-502
#LAB 5
#part 3



       .data
	   
NL:		.asciiz "\n"
mesg:    .asciiz "Please input string to convert\n"
mesg2:	.asciiz "the reversed string is:"
delim:     .asciiz  "\n" # new line is delim
buff:   .space  255 #255 byte buffer for string input

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
        jal reverse_s 		#jump to sum and link address..(store current address in ra)
		add $t0, $v0, $0 #save function result


        li       $v0, 4           
		la $a0, mesg2
		syscall
		
        la       $a0, buff
        syscall   


        li       $v0, 10
        syscall                 # exit
#reverse_s a0 is string a1 is delim char
reverse_s:	li $v0, 0
		li $t0, 0 #initialize to 0 use as counter
		Loop1:
			lb $t1, 0($a0) #load first byte!
			beq $t1, $a1 end1 #quit if delim char
			addi $sp, -1 #reserve space on stack to save each int for decimal conversion
			sb $t1, 0($sp) #save char on stack
			addi $a0, 1 #increment buffer index
			addi $t0, 1
		j Loop1
		end1:
		la $a0, buff #go back to begin of buffer
		
		Loop2:
			lb $t1, 0($sp) #pop off stack
			addi $sp, 1
			beq $t0, $0 end2 #end when counter is 0
			sb $t1,($a0)
			addi $a0, 1
			addi $t0, -1
		j Loop2
		end2:
		
		
		jr $ra #jump register
