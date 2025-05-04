%include 'functions.asm'

SECTION .text
global _start

_start:
        mov ecx, 0

.next_number:
        mov eax, ecx
        call int_println
        inc ecx
        cmp ecx, 250
        jne .next_number

        call exit
