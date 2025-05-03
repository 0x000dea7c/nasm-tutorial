%include 'functions.asm'

SECTION .data
        msg_one db 'Thanks for talking to me', 0h
        msg_two db 'You are pretty', 0h
        msg_three db 'I wonder...', 0h

SECTION .text
global _start

_start:
        mov eax, msg_one
        call string_println

        mov eax, msg_two
        call string_println

        mov eax, msg_three
        call string_println

        call exit
