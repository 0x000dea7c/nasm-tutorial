        SECTION .data
        msg db 'hey, hello you', 0Ah

        SECTION .text
        global _start

_start:
        mov edx, 15             ; number of bytes to write
        mov ecx, msg            ; move the address of `msg` to ecx
        mov ebx, 1              ; write to stdout(1)
        mov eax, 4              ; call sys_write(kernel OPCODE 4)
        int 80h

        mov eax, 1              ; call sys_exit(kernel OPCODE 1)
        mov ebx, 0              ; we are going to return 0 (no errors)
        int 80h
