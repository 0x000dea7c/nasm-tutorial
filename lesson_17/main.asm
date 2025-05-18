%include 'functions.asm'

SECTION .data
        msg1 db 'Jumping to finished label.', 0h
        msg2 db 'Inside subroutine number: ', 0h
        msg3 db 'Inside subroutine "finished".', 0h
SECTION .text
global _start

_start:
subroutine_one:
        mov eax, msg1
        call string_println
        jmp .finished

.finished:
        mov eax, msg2
        call string_println
        mov eax, 1
        call int_println

subroutine_two:
        mov eax, msg1
        call string_println
        jmp .finished

.finished:
        mov eax, msg2
        call string_println
        mov eax, 2
        call int_println
        mov eax, msg1
        call string_println
        jmp finished

finished:
        mov eax, msg3
        call string_println
        call exit
