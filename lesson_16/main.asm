%include 'functions.asm'

SECTION .text
global _start

_start:
        pop ecx                 ; get the number of arguments passed to our program
        pop edx                 ; pop the program's name
        sub ecx, 1              ; we don't count the program's name as a real argument
        mov edx, 0              ; this is where we will be storing our additions

.next_argument:
        cmp ecx, 0
        jz .no_more_arguments
        pop eax                 ; pop the next argument off the stack
        call ascii_to_integer
        add edx, eax
        dec ecx
        jmp .next_argument

.no_more_arguments:
        mov eax, edx            ; move our result to eax and print
        call int_println
        call exit
