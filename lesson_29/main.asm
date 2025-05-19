%include 'functions.asm'

SECTION .data
        ipproto_tcp    dd 6
        sock_stream    dd 1
        pf_inet        dd 2
        sys_socket     dd 1
        sys_socketcall dd 102
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
        call int_println        ; debug to see what the output is. It should print something > 0
_exit:
        call exit
