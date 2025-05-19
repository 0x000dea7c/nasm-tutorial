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
        sys_fork         dd 2
        sys_read         dd 3
        sys_write        dd 4
        sys_close        dd 6
        max_queue_length db 1
        msg_error        db 'Error calling bind', 0h
        msg_response     db 'HTTP/1.1 200 OK', 0Dh, 0Ah, 'Content-Type: text/html', 0Dh, 0Ah, 'Content-Length: 9', 0Dh, 0Ah, 0Dh, 0Ah, 'Hey, hey!', 0Dh, 0Ah, 0h
        msg_response_length equ $-msg_response
SECTION .bss
        buffer resb 256
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
        int 80h                 ; this blocks

_fork:
        mov esi, eax            ; move the fd of the accepted socket to esi
        mov eax, [sys_fork]
        int 80h
        cmp eax, 0              ; if we are the child, go read
        jz _read
        jmp _accept             ; otherwise keep accepting
_read:
        mov edx, 256            ; buffer length
        mov ecx, buffer
        mov ebx, esi
        mov eax, [sys_read]
        int 80h
        mov eax, buffer
        call string_println

_write:
        mov edx, msg_response_length
        mov ecx, msg_response
        mov ebx, esi            ; move the fd to ebx
        mov eax, [sys_write]
        int 80h

_close:
        mov ebx, esi            ; again the fd
        mov eax, [sys_close]
        int 80h

_exit:
        call exit
