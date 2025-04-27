        SECTION .data
        msg db 'This is a much more longer string!', 0Ah

        SECTION .text
        global _start

_start:
        mov ebx, msg            ; position ourselves at the beginning of msg
        mov eax, ebx            ; same here, we'll be manipulating EAX

nextchar:
        cmp byte [eax], 0       ; no more characters to read? This sets the zero flag (ZF)
        jz finished             ; no, then jump to end
        inc eax                 ; increment one byte
        jmp nextchar            ; and loop

finished:
        sub eax, ebx            ; subtract both addresses, the number of bytes to write is in eax

        mov edx, eax            ; number of bytes to write
        mov ecx, msg            ; move the address of `msg` to ecx
        mov ebx, 1              ; write to stdout(1)
        mov eax, 4              ; call sys_write(kernel OPCODE 4)
        int 80h

        mov eax, 1              ; call sys_exit(kernel OPCODE 1)
        mov ebx, 0              ; we are going to return 0 (no errors)
        int 80h
