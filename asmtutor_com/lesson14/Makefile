CFLAGS = -Wall -Wextra -pedantic -O2

THIS = multiply
.PHONY : all ccount $(THIS)

$(THIS):
	nasm -f elf -o $@.o $@.asm
	ld -m elf_i386 -o $@ $@.o
	./$@ first next last

all: $@ clean

clean:
	rm -f $@
	rm -f $@.o
