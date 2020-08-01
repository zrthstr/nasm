; print command line arguments
; iterate over argv

%include 'functions.asm'

SECTION .data
msg1	db	'Whats your name?', 0h
msg2	db	'Hello, ', 0h

SECTION .bss
sinput:	resb	255


SECTION .text
global  _start

_start:

	mov	eax, msg1
	call	sprint

				; read(int fd, void *buf, size_t count);
	mov	edx, 255
	mov	ecx, sinput
	mov	ebx, 0 ; STDIN
	mov	eax, 3 ; sys_read
	int	80h

	mov	eax, msg2
	call	sprint

	mov	eax, sinput
	call	sprint

	call	quit
