; Calculator (Additin)

%include	'functions.asm'

SECTION	.text
global 	_start

_start:
	mov	eax, 90		; mov our first number into eax
	mov	ebx, 9		; mov our secound number into ebx
	add	eax, ebx	; add ebx to eax

	call	iprintLF

	call	quit

