all:
	nasm -f elf main.asm
	ld -m elf_i386 main.o -o main

run:
	./main 69 30 10
