; print command line arguments
; iterate over argv

%include 'functions.asm'


SECTION .text
global  _start

_start:

        pop ecx

nextArg:
        cmp     ecx, 0
        jz noMoreArgs
        pop eax
        call sprint_line
        dec ecx
        jmp nextArg


noMoreArgs:

        call    quit
