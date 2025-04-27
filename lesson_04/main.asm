        SECTION .data
        msg db 'Thanks for talking to me', 0Ah

        SECTION .text
        global _start

_start:
        mov eax, msg            ; the argument to our function string_length
        call string_length      ; the result of our function is in EAX

        mov edx, eax            ; number of bytes to write
        mov ecx, msg            ; move the address of `msg` to ecx
        mov ebx, 1              ; write to stdout(1)
        mov eax, 4              ; call sys_write(kernel OPCODE 4)
        int 80h

        mov eax, 1              ; call sys_exit(kernel OPCODE 1)
        mov ebx, 0              ; we are going to return 0 (no errors)
        int 80h

string_length:
        push ebx                ; since we're using EBX, push it to store whatever it had
        mov ebx, eax            ; prepare to do pointer arithmetic

.next_char:
        cmp byte [eax], 0
        jz .finished
        inc eax
        jmp .next_char

.finished:
        sub eax, ebx            ; subtract both addresses, the number of bytes to write is in eax
        pop ebx                 ; leave ebx as it was
        ret
