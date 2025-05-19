%include 'functions.asm'

SECTION .data
        filename db 'FuckMe.txt', 0h
        msg_file_exist db 'File exists!', 0h
        msg_file_doesnt_exist db "File doesn't exist!", 0h
        sys_open dd 5
        open_read_only dd 0
SECTION .text
global _start
_start:
        mov ecx, [open_read_only]
        mov ebx, filename
        mov eax, [sys_open]
        int 80h
        cmp eax, 0
        jle .file_doesnt_exist
        mov eax, msg_file_exist
        call string_println
        call exit

.file_doesnt_exist:
        mov eax, msg_file_doesnt_exist
        call string_println
        call exit
