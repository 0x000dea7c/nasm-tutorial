%include 'functions.asm'

SECTION .data
        filename db 'FuckMe.txt', 0h
        sys_unlink dd 10        ; means deleting a file
        msg_file_doesnt_exist db "File doesn't exist!", 0h
SECTION .text
global _start
_start:
        mov ebx, filename
        mov eax, [sys_unlink]
        int 80h
        cmp eax, 0
        jnz .file_doesnt_exist
        call exit

.file_doesnt_exist:
        mov eax, msg_file_doesnt_exist
        call string_println
        call exit
