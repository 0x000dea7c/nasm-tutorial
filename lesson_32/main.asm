%include 'functions.asm'

SECTION .data
        ipproto_tcp      dd 6
        sock_stream      dd 1
        pf_inet          dd 2
        port             dd 0x2923 ; 9001 in dec
        sys_socket       dd 1
        ip_address       dd 0x00000000
        sockaddr_length  dd 16
        sys_bind         dd 2
        sys_socketcall   dd 102
        sys_listen       dd 4
        sys_socketcalll  dd 102
        sys_accept       dd 5
        max_queue_length db 1
        msg_error        db 'Error calling bind', 0h
SECTION .text
global _start
_start:
        xor eax, eax
        xor ebx, ebx
        xor edi, edi
        xor esi, esi
_socket:
        push dword [ipproto_tcp] ; these are the arguments for the socket call
        push dword [sock_stream]
        push dword [pf_inet]
        mov ecx, esp            ; move address of arguments onto ecx
        mov ebx, [sys_socket]
        mov eax, [sys_socketcall]
        int 80h
_bind:
        mov edi, eax           ; we have the fd of the socket, store it in edi
        push dword [ip_address]
        push word [port]
        push word [pf_inet]
        mov ecx, esp            ; move the address of the stack pointer into ecx
        push dword [sockaddr_length] ; it's a combination of padding and the actual values
        push ecx                     ; push the address of the arguments
        push edi                     ; push the file descriptor
        mov ecx, esp                 ; move the address of arguments into ecx
        mov ebx, [sys_bind]
        mov eax, [sys_socketcall]
        int 80h
        cmp eax, 0

_listen:
        movzx eax, byte [max_queue_length]
        push eax
        push edi                ; push the file descriptor
        mov ecx, esp            ; address of arguments into ecx
        mov ebx, [sys_listen]
        mov eax, [sys_socketcall]
        int 80h

_accept:
        push byte 0             ; address length argument
        push byte 0             ; address argument
        push edi                ; push fd
        mov ecx, esp
        mov ebx, [sys_accept]
        mov eax, [sys_socketcall]
        int 80h

_exit:
        call exit
