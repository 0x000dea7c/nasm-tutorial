%include 'functions.asm'

SECTION .data
        filename db 'FuckMe.txt', 0h
        file_message db 'Whatever man', 0h
        file_contents_length equ $-file_message
        file_permissions dd 0777o
        sys_write dd 4
        sys_open dd 5
        sys_close dd 6
        sys_creat dd 8
        open_read_only dd 0
SECTION .bss
        file_contents resb 256
SECTION .text
global _start
_start:
        mov ecx, [file_permissions]
        mov ebx, filename
        mov eax, [sys_creat]
        int 80h
        push eax                ; push the file descriptor here for later use
        mov edx, file_contents_length
        mov ecx, file_message
        mov ebx, eax            ; remember: file descriptor in eax
        mov eax, [sys_write]
        int 80h
        pop eax
        mov ebx, eax            ; move the file descriptor to ebx
        mov eax, [sys_close]
        int 80h
        call exit
