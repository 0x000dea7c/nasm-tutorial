%include 'functions.asm'

SECTION .bss
        user_input_msg resb 255     ; reserve 255 bytes for the user input
SECTION .data
        name_prompt_msg db 'Please enter your name: ', 0h
        hello_msg db 'Hello, ', 0h
SECTION .text
global _start

_start:
        mov eax, user_input_msg
        call string_print

        ; prepare to call sys_read
        mov edx, 255            ; bytes to read
        mov ecx, user_input_msg ; buffer
        mov ebx, 0              ; we want to use stdin (0)
        mov eax, 3              ; sys_read (3)
        int 80h

        mov eax, hello_msg
        call string_print

        mov eax, user_input_msg
        call string_println

        call exit
