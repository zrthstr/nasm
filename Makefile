
all:
	nasm -f elf64 -o counter.o counter.asm
	ld -o counter counter.o

clean:
	rm -f counter counter.o
