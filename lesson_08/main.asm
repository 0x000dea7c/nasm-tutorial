%include 'functions.asm'

SECTION .data
        msg_one db 'Thanks for talking to me', 0h
        msg_two db 'You are pretty', 0h
        msg_three db 'I wonder...', 0h

SECTION .text
global _start

_start:
        pop ecx                 ; get rid of the number of arguments and store it in ecx

.next_argument:
        cmp ecx, 0              ; do we have any arguments left?
        jz .no_more_arguments   ; no
        pop eax                 ; yes, ok, pop the next one
        call string_println
        dec ecx
        jmp .next_argument

.no_more_arguments:
        call exit
