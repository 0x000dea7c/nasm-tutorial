%include 'functions.asm'

SECTION .data
        filename db 'FuckMe.txt', 0h
        sys_open dd 5
        sys_read dd 3
        open_read_only dd 0
SECTION .bss
        file_contents resb 256
SECTION .text
global _start
_start:
        mov ecx, [open_read_only]
        mov eax, [sys_open]
        mov ebx, filename
        int 80h
        mov edx, 24             ; this is hard coded, it's the number of bytes inside the file
        mov ecx, file_contents  ; our buffer
        mov ebx, eax            ; move the file descriptor to ebx
        mov eax, [sys_read]
        int 80h
        mov eax, file_contents
        call string_println
        call exit
