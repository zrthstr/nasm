; print numbers from 1 to 10

%include 'functions.asm'

SECTION .text
global _start

_start:
        mov     ecx, 0

nextNumber:
        inc     ecx
        mov     eax, ecx

        add     eax, 48
        push    eax
        mov     eax, esp
        call    sprint_line
        cmp     ecx, 10
        pop     eax
        jne     nextNumber

        call quit

