%include 'functions.asm'

SECTION .text
global _start

_start:
        mov ecx, 0

.next_number:
        mov eax, ecx
        add eax, 48             ; ASCII representation of ecx
        push eax                ; push eax onto the stack
        mov eax, esp            ; now grab the address of the character we just pushed
        call string_println     ; and pass it to string_println
        pop eax
        inc ecx
        cmp ecx, 10
        jne .next_number

        call exit
