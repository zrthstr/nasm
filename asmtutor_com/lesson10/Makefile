
THIS = count

.PHONY : $(THIS)

$(THIS):
	#nasm -f elf64 -o $(THIS).o $(THIS).asm
	nasm -f elf -o $(THIS).o $(THIS).asm
	ld -m elf_i386 -o $(THIS) $(THIS).o
	./$(THIS)

all: $(THIS) clean

clean:
	rm -f $(THIS)
	rm -f $(THIS).o
