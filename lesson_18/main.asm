%include 'functions.asm'

SECTION .data
        msg_fizz db 'Fizz', 0h
        msg_buzz db 'Buzz', 0h
SECTION .text
global _start

_start:
        mov esi, 0              ; esi for check_fizz
        mov edi, 0              ; edi for check_buzz
        mov ecx, 0              ; ecx is our counter

next_number:
        inc ecx

.check_fizz:
        mov edx, 0              ; the remainder is stored in edx
        mov eax, ecx            ; the dividend is our counter
        mov ebx, 3              ; the divisor is 3
        div ebx                 ; quotient in eax, remainder in edx
        mov esi, edx            ; store the remainder into esi to know if it was divisible by 3 or not
        cmp edx, 0              ; if it's divisible, then print Fizz
        jne .check_buzz         ; not divisible, try check_buzz
        mov eax, msg_fizz
        call string_print

.check_buzz:
        mov edx, 0
        mov eax, ecx
        mov ebx, 5
        div ebx
        mov edi, edx
        cmp edx, 0
        jne .check_integer
        mov eax, msg_buzz
        call string_print

.check_integer:                 ; if it's not divisible by 3 or 5 it prints the number
        cmp esi, 0
        je .continue
        cmp edi, 0
        je .continue
        mov eax, ecx
        call int_print

.continue:
        mov eax, 0Ah            ; linefeed
        push eax                ; push the address of eax onto the stack for printing
        mov eax, esp            ; get the address pointer of the newline character
        call string_print
        pop eax
        cmp ecx, 100
        jne next_number
        call exit
