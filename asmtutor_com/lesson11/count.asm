; print numbers from 1 to 10 using itoa

%include 'functions.asm'

SECTION .text
global _start

_start:
        mov     ecx, 0

nextNumber:
        inc     ecx
        mov     eax, ecx
	call	iprintLF
	cmp	ecx, 10
	jne	nextNumber

        call quit

