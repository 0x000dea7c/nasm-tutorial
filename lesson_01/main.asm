        ;;
        ;; This SEGFAULTs at the end, but it's fine for now.
        ;;
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
