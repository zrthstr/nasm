; echo_len

global _start

;        extern  puts

section .data
        msg: db "thjjjsijdsijdsest", 0xA

section .text

_start:

        mov edx, msg
        mov ecx, msg

nexchr:
        cmp byte [edx], 0
        jz done
        inc edx
        jmp nexchr

done:
        sub edx, ecx
        mov ecx, msg
        mov ebx, 1
        mov eax, 4
        int 0x80

        mov ebx, 0
        mov eax, 1
        int 0x80
