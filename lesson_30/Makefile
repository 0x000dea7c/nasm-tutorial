all:
	nasm -f elf main.asm -g
	ld -m elf_i386 main.o -o main

run:
	./main
