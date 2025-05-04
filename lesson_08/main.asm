%include 'functions.asm'

SECTION .data
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
