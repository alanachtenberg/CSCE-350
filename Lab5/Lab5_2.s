#Alan Achtenberg
#CSCE 350-502
#LAB 5
#part 2


       .data
	   
NL:		.asciiz "\n"
mesg:    .asciiz "Please input string to convert\n"
mesg2:	.asciiz "produces the int :"
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
        jal atoi 		#jump to sum and link address..(store current address in ra)
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

atoi:	li $v0, 0
		li $t0, 0 #initialize to 0 use as counter
		li $t3, 10 #use as constant
		li $t4, 0 #power of 10
		Loop1:
			lb $t1, 0($a0) #load first byte!
			addi $t1, -48 #bias because ascii '0'=48
			blt $t1, 0, end1 #check for correct input range
			bgt $t1, 9, end1
			addi $sp, -4 #reserve space on stack to save each int for decimal conversion
			sw $t1, 0($sp) #save int on stack
			addi $a0, 1 #increment buffer index
			addi $t0, 1
		j Loop1
		end1:
		
		Loop2:
			
			lw $t1, 0($sp) #use stack to get most significant bit
			addi $sp, 4
			beq $t0, $0 end2 #end when counter is 0
			
			
			mult $t3, $t4
			mflo $t4
			bne $t4, 0 skip #edge case when i=0 10^0 is 1 not 0
				addi $t4, $0, 1
			skip:
			
			mult $t1, $t4
			mflo $t1
			add $v0, $v0, $t1
			addi $t0, -1
		j Loop2
		end2:
		
		
		jr $ra #jump register
