%include 'functions.asm'

SECTION .text
global _start

_start:
        mov eax, 60
        mov ebx, 11
        mul ebx
        call int_println

        call exit
