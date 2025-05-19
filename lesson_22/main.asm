%include 'functions.asm'

SECTION .data
        filename db 'FuckMe.txt', 0h
        permissions dd 0777o
        sys_creat dd 8
SECTION .text
global _start
_start:
        mov ecx, [permissions]
        mov ebx, filename
        mov eax, [sys_creat]
        int 80h
        call exit
