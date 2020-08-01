
THIS = null

$(THIS):
	#nasm -f elf64 -o $(THIS).o $(THIS).asm
	nasm -f elf -o $(THIS).o $(THIS).asm
	ld -m elf_i386 -o $(THIS) $(THIS).o
	./$(THIS)
	@rm $(THIS)

all: clean $(THIS)

clean:
	rm -f $(THIS)
	rm -f $(THIS).o
