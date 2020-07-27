; hello world
global _start

section .data
        ; Align to nearest 2 byte boundry. must be power of two
        align 2
        str: db 'Hello, world!',0xA
        ; String, a collection of bytes
        strLen: equ $-str

section .bss

section .text
        _start:

;
;       op         dst,  src
;
                                ;
                                ; Call write(2) syscall:
                                ;       ssize_t write(int fd, const void *buf, size_t count)
                                ;
        mov        edx, strLen  ; Arg three: the length of the string
        mov        ecx, str     ; Arg two: the addr of the string
        mov        ebx, 1       ; Arg one: file descriptor, stdout
        mov        eax, 4       ; Syscall number, "write(2)"
        int        0x80         ; Interupt 80


                                ; Call exit(3) syscall
                                ;        void exit(int status)
                                ;
        mov        ebx, 0       ; Arg one: status
        mov        eax, 1       ; Syscall number
        int        0x80
