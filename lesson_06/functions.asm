        ;;
        ;; arguments:
        ;;
        ;; string message (eax)
        ;;
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

        ;;
        ;; arguments:
        ;;
        ;; string message (eax)
        ;;
string_print:
        ;; we are going to be using all of those, so push them
        push edx
        push ecx
        push ebx
        push eax
        call string_length

        mov edx, eax            ; store the string length in edx
        pop eax                 ; get the address of the string back

        mov ecx, eax            ; move that into ecx
        mov ebx, 1              ; stdout
        mov eax, 4              ; 4(kernel OPCODE for sys_write)
        int 80h                 ; write

        pop ebx                 ; restore everything
        pop ecx
        pop edx
        ret

exit:
        mov ebx, 0              ; 0 no errors, TODO: actually this should be parametrised
        mov eax, 1              ; 1(kernel OPCODE for sys_exit)
        int 80h
        ret
