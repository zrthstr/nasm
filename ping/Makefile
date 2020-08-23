CFLAGS = -Wall -Wextra -pedantic -O2
DEST_HOST = 8.8.8.8

.PHONY : c_ping_receive c_ping_send c_ping

python_dep:
	sudo pip3 install pythonping

python_ping:
	################# python ping #######################
	sudo ./ping.py $(DEST_HOST)


c_ping: c_ping_receive c_ping_send
	################### c ping ##########################

c_ping_send:
	gcc $(CFLAGS) -o $@ ping_send.c
	sudo ./$@ 8.8.8.8

c_ping_receive:
	gcc $(CFLAGS) -o $@ ping_receive.c
	sudo ./$@ &

nasm_ping:
	################# nasm ping #########################
	nasm -f elf -o $@.o ping.asm
	ld -m elf_i386 -o $@ $@.o
	./$@ $(DEST_HOST)

ping: python_ping c_ping #nasm_ping
