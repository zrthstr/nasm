CFLAGS = -Wall -Wextra -pedantic -O2

THIS = count
.PHONY : all ccount $(THIS)

$(THIS):
	#nasm -f elf64 -o $@.o $@.asm
	nasm -f elf -o $@.o $@.asm
	ld -m elf_i386 -o $@ $@.o
	./$@

all: $@ clean

clean:
	rm -f $@
	rm -f $@.o

ccount:
	gcc $(CFLAGS) -o $@ $@.c
	./ccount
