%include 'functions.asm'

SECTION .data
        ipproto_tcp      dd 6
        sock_stream      dd 1
        pf_inet          dd 2
        port             dd 0x5000 ; 80 in reverse byte order
        sys_socket       dd 1
        ip_address       dd 0x4227a28b
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
        sys_connect      dd 3
        max_queue_length db 1
        msg_error        db 'Error calling bind', 0h
        msg_request      db 'GET / HTTP/1.1', 0Dh, 0Ah, 'Host: 139.162.39.66:80', 0Dh, 0Ah, 0Dh, 0Ah, 0h
        msg_request_length equ $-msg_request
SECTION .bss
        buffer resb 1
SECTION .text
global _start
_start:
        xor eax, eax
        xor ebx, ebx
        xor edi, edi
_socket:
        push dword [ipproto_tcp] ; these are the arguments for the socket call
        push dword [sock_stream]
        push dword [pf_inet]
        mov ecx, esp            ; move address of arguments onto ecx
        mov ebx, [sys_socket]
        mov eax, [sys_socketcall]
        int 80h
_connect:
        mov edi, eax           ; we have the fd of the socket, store it in edi
        push dword [ip_address]
        push word [port]
        push word [pf_inet]
        mov ecx, esp            ; move the address of the stack pointer into ecx
        push dword [sockaddr_length] ; it's a combination of padding and the actual values
        push ecx                     ; push the address of the arguments
        push edi                     ; push the file descriptor
        mov ecx, esp                 ; move the address of arguments into ecx
        mov ebx, [sys_connect]
        mov eax, [sys_socketcall]
        int 80h

_write:
        mov edx, msg_request_length
        mov ecx, msg_request
        mov ebx, edi            ; write into this fd
        mov eax, [sys_write]
        int 80h

_read:
        mov edx, 1            ; buffer length
        mov ecx, buffer
        mov ebx, edi
        mov eax, [sys_read]
        int 80h
        cmp eax, 0              ; nothing more to read
        jz _close
        mov eax, buffer
        call string_print
        jmp _read

_close:
        mov ebx, esi            ; again the fd
        mov eax, [sys_close]
        int 80h

_exit:
        call exit
