%include 'functions.asm'

SECTION .data
        filename db 'FuckMe.txt', 0h
        file_updated_message db 'Appending this to the end', 0h
        file_updated_message_length equ $-file_updated_message
        sys_write dd 4
        sys_open dd 5
        sys_close dd 6
        sys_lseek dd 19
        open_write_only dd 1
        seek_end dd 2
SECTION .text
global _start
_start:
        mov ecx, [open_write_only]
        mov ebx, filename
        mov eax, [sys_open]
        int 80h
        mov edx, [seek_end]
        mov ecx, 0              ; don't move any bytes
        mov ebx, eax            ; move the file descriptor to ebx
        mov eax, [sys_lseek]
        int 80h
        mov edx, file_updated_message_length
        mov ecx, file_updated_message
        mov eax, [sys_write]
        int 80h
        mov ebx, eax            ; and close the file because we're good citizens
        mov eax, [sys_close]
        int 80h
        call exit
