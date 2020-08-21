; division
; print quotient msg1 remainder LF

%include 'functions.asm'

SECTION .data

msg1    db      ' remainder '

SECTION .text
global  _start

_start:
        mov     eax, 90         ; mov 90 into eax
        mov     ebx, 9          ; mov 9 into ebx
        div     ebx             ; divide eax by ebx
        call iprint

	mov eax, msg1		; print message
	call sprint

	mov eax, edx		; print int + LF
	call iprintLF

        call quit
