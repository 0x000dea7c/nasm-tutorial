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

;;
;; arguments:
;;
;; string message (eax)
;;
string_println:
        call string_print

        push eax                ; push eax onto the stack to preserve it
        mov eax, 0Ah            ; mov the linefeed to eax
        push eax                ; now push the linefeed (this relies on little endian arch?)

        mov eax, esp            ; store in eax the address of esp after pushing the linefeed
        call string_print
        pop eax                 ; remove the linefeed from the stack
        pop eax                 ; restore the original value of eax
        ret

exit:
        mov ebx, 0              ; 0 no errors, TODO: actually this should be parametrised
        mov eax, 1              ; 1(kernel OPCODE for sys_exit)
        int 80h
        ret

;;
;; arguments:
;;
;; void int_print (int)
;;
;; this function needs the following registers:
;;
;; eax
;; ecx
;; edx
;; ecx
;;
int_print:
        push eax
        push ecx
        push edx
        push esi
        mov ecx, 0              ; counter of how many bytes we need to print in the end

.int_print_divide_loop:
        inc ecx                 ; increment the counter of bytes to print
        mov edx, 0              ; zero out edx
        mov esi, 10             ; store 10 in esi, we will be dividing by 10
        idiv esi                ; divide eax by esi, the remainder is in edx
        add edx, 48             ; convert the remainder to a character
        push edx                ; push the remainder onto the stack
        cmp eax, 0              ; can we divide anymore?
        jnz .int_print_divide_loop ; yes, keep looping

.int_print_print_loop:
        dec ecx                 ; decrement the counter
        mov eax, esp            ; move the stack pointer onto eax for printing
        call string_print
        pop eax                 ; get rid of this character
        cmp ecx, 0              ; are we done?
        jnz .int_print_print_loop         ; no, keep looping

        ; restore values
        pop esi
        pop edx
        pop ecx
        pop eax
        ret

int_println:
        call int_print

        push eax                ; save the contents of eax
        mov eax, 0Ah            ; store the linefeed onto eax
        push eax                ; push the linefeed onto the stack
        mov eax, esp            ; grab the linefeed memory address and store it into eax for calling print
        call string_print
        pop eax
        pop eax
        ret

ascii_to_integer:
        push ebx                ; we're going to use these, preserve them
        push ecx
        push edx
        push esi
        mov esi, eax            ; the string address is in eax, so move it to esi
        mov eax, 0
        mov ecx, 0

.ascii_to_integer_multiply_loop:
        xor ebx, ebx
        mov bl, [esi + ecx]     ; move a byte into ebx register's lower half (bl)
        cmp bl, 48              ; compare with '0'
        jl .ascii_to_integer_multiply_loop_finished
        cmp bl, 57              ; compare with '9'
        jg .ascii_to_integer_multiply_loop_finished
        sub bl, 48              ; convert the character to a digit
        add eax, ebx            ; add the digit to eax
        mov ebx, 10             ; this is the interesting part of the algorithm
        mul ebx                 ; multiply what we have in eax times ebx
        inc ecx                 ; fetch next byte
        jmp .ascii_to_integer_multiply_loop

.ascii_to_integer_multiply_loop_finished:
        cmp ecx, 0
        je .ascii_to_integer_multiply_loop_restore
        mov ebx, 10
        div ebx

.ascii_to_integer_multiply_loop_restore:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
