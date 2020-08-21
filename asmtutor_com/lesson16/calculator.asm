;--------------------------------
; Calculator (ATOI)


%include 'functions.asm'

SECTION .text
global _start

_start:
        pop     ecx             ; get argc, the number of arguments
        pop     edx,            ; second value on stack is the program name
        sub     ecx, 1          ; decrease ecx by one (number of arguments without program name)
        mov     edx, 0          ; init our data register to store additions

nextArg:
        cmp     ecx, 0h         ; check if no args left
        jz      noMoreArgs      ; if zero flag is set jump to noMoreArgs
        pop     eax             ; pop next argument off stack
        call    atoi            ; convert ascii string to to decimal int
        add     edx, eax        ; perform addition
        dec     ecx             ; decrease ecx (args left) by one
        jmp     nextArg         ; jump to nextArg lable


noMoreArgs:
        mov     eax, edx        ; move result into eax for printing
        call    iprintLF        ; print integer and LF
        call    quit

