CFLAGS = -Wall -Wextra -pedantic -O2

THIS = calculator catoi
.PHONY : all ccount $(THIS)

$(THIS):
	nasm -f elf -o $@.o $@.asm
	ld -m elf_i386 -o $@ $@.o
	./$@
	./$@ 1
	./$@ 11 22 33

all: $@ clean

catoi:
	gcc $(CFLAGS) -o $@ $@.c
	./catoi 111
	@echo ""
	./catoi 100 200 345

clean:
	rm -f $@
	rm -f $@.o
