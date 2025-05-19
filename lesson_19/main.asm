%include 'functions.asm'

SECTION .data
        command     db '/bin/echo', 0h
        arg1        db "Hey, hey! Now I don't need to compute the length of my string!", 0h
        arguments   dd command
                    dd arg1     ; arguments passed to the command line
                    dd 0h       ; end of the struct
        environment dd 0h       ; arguments to pass as environment variables (none here)
SECTION .text
global _start

_start:
        mov edx, environment
        mov ecx, arguments
        mov ebx, command
        mov eax, 11             ; 11 (SYS_EXECVE)
        int 80h
        call exit
