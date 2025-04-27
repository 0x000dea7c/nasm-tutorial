        %include 'functions.asm'

        SECTION .data
        msg_one db 'Thanks for talking to me', 0Ah, 0h ; added the zero byte here
        msg_two db 'You are pretty', 0Ah, 0h           ; here as well

        SECTION .text
        global _start

_start:
        mov eax, msg_one
        call string_print

        mov eax, msg_two
        call string_print

        call exit
