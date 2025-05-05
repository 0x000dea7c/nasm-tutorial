%include 'functions.asm'

SECTION .text
global _start

_start:
        mov eax, 1
        mov ebx, 0
        add eax, ebx
        call int_println

        call exit
