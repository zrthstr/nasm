
THIS = print

print:
	yasm -f elf64 -o $(THIS).o $(THIS).asm
	ld -o $(THIS) $(THIS).o
	./$(THIS)

all: clean $(THIS)

clean:
	rm -f $(THIS) $(THIS).o
