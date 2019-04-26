section .data
	counter db 48,10

section .text
	global _start

_start:
	call _printCounter
	call _incrementCounter
	cmp byte [counter], 57
	jne _start
	call _exit

_printCounter:
	mov rax, 1
	mov rdi, 1
	mov rsi, counter
	mov rdx, 2
	syscall
	ret

_incrementCounter:
	inc byte [counter]
	ret

_exit:
	mov rax, 60
	mov rdi, 0
	syscall
	ret
