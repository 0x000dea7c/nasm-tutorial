%include 'functions.asm'

SECTION .data
        msg db 'Seconds elapsed since 1 Jan 1970: ', 0h
SECTION .text
global _start

_start:
        mov eax, msg
        call string_println
        mov eax, 13             ; 13 (SYS_TIME)
        int 80h                 ; the number of seconds is returned in eax
        call int_println
        call exit
