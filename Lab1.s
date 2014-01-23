## Your first MIPS assembly program

## Notice the stylized format of the code: 3 columns:

## (1) Optional labels,

## (2) Machine instructions, assembler directives and their operands,

## (3) Optional comments: everything to the right of a '#' until end of line is

## ignored.



.data # "data section" global, static modifiable data



SID:    .word 100

spc1:   .asciiz " "

nl:     .asciiz "\n"

tb:     .asciiz "\t"

msg1:   .asciiz "Hello, World\n"

msg2:   .asciiz "My name is: Alan Achtenberg\n"

msg3:   .asciiz "\nMy name is still Alan Achtenberg !\n"

.text    # "text section" code and read-only data



.globl main # declare `main' as a global symbol



main:   la $a0, msg1



        li $v0, 4 # "print string" system call

        syscall



        la $a0, msg2

        li $v0, 4

        syscall



        lw $a0, SID

        la $a1, spc1



Loop:   beq $0, $a0, Exit



        add $a0, $a0, -1

        li $v0, 1 # "print int" system call

        syscall



        move $t0, $a0

        move $a0, $a1

        li $v0, 4

        syscall



        move $a0, $t0

        j Loop



Exit:   la $a0, msg3



        li $v0, 4

        syscall

        ## Exit from program

        li $v0, 10 # "Exit" system call

        syscall