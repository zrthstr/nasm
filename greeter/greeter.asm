; greet
global _start

section .data
        align 2
        question: db "whats your name:"
        questionLen: equ $-question
        fss: db "%s", 0xA
        fssLen: equ $-fss
        answer:   db "hello %s", 0xA
        anserLen: equ $-answer

section .bss
        pname: resb 32 ; no idea

section .text
;        extern scanf
        _start:

;
;       op         dst,  src
;
                                ;
                                ; Call write(2) syscall:
                                ;       ssize_t write(int fd, const void *buf, size_t count)
                                ;
        mov        edx, questionLen  ; Arg three: the length of the string
        mov        ecx, question     ; Arg two: the addr of the string
        mov        ebx, 1       ; Arg one: file descriptor, stdout
        mov        eax, 4       ; Syscall number, "write(2)"
        int        0x80         ; Interupt 80

                                ; Call scanf("%s", answer)



                                ; Call exit(3) syscall
                                ;        void exit(int status)
                                ;
        mov        ebx, 0       ; Arg one: status
        mov        eax, 1       ; Syscall number
        int        0x80
