%include 'functions.asm'

SECTION .data
        filename db 'FuckMe.txt', 0h
        msg db 'This is another stringy!', 0h
        permissions dd 0777o
        sys_creat dd 8
        sys_write dd 4
SECTION .text
global _start
_start:
        mov ecx, [permissions]  ; create the file if it doesn't exist
        mov ebx, filename
        mov eax, [sys_creat]
        int 80h

        mov ebx, eax            ; move the file descriptor to ebx
        mov eax, msg
        call string_length
        mov edx, eax            ; move string length to ebx
        mov ecx, msg            ; move the address of the string into ecx
        mov eax, [sys_write]
        int 80h
        call exit
