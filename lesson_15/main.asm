%include 'functions.asm'

SECTION .data
        msg db ' remainder '
SECTION .text
global _start

_start:
        mov eax, 12
        mov esi, 5
        div esi                 ; quotient stored in eax, remainder in edx
        call int_print          ; print the quotient
        mov eax, msg            ; print message
        call string_print
        mov eax, edx            ; now print the remainder
        call int_println        ; woho

        call exit
