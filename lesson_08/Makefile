all:
	nasm -f elf main.asm
	ld -m elf_i386 main.o -o main

run:
	./main hello this is a test! 10 20 30
