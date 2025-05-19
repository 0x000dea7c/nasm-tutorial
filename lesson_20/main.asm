%include 'functions.asm'

SECTION .data
        msg_child db 'Hello, I am the child process.', 0h
        msg_parent db 'Hello, I am the parent process.', 0h
SECTION .text
global _start

_start:
        mov eax, 2
        int 80h
        cmp eax, 0
        jz .child

.parent:
        mov eax, msg_parent
        call string_println
        call exit

.child:
        mov eax, msg_child
        call string_println
        call exit
