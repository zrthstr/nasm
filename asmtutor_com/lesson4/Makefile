
THIS = echo_len

$(THIS):
	nasm -f elf64 -o $(THIS).o $(THIS).asm
	ld -o $(THIS) $(THIS).o
	./$(THIS)
	@rm $(THIS)

all: clean $(THIS)

clean:
	rm -f $(THIS) $(THIS).o
