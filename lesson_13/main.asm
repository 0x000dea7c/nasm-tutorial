%include 'functions.asm'

SECTION .text
global _start

_start:
        mov eax, 60
        mov ebx, 11
        sub eax, ebx
        call int_println

        call exit
