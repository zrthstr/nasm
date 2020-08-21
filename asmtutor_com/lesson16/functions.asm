;--------------------------------
; int atoi(Char char)
; Ascii to integer function (atoi)
atoi:
        push    ebx
        push    ecx
        push    edx
        push    esi
        mov     esi, eax 	; move pointer in eax int esi, out number to convert
        mov     eax, 0		; initialise eax with 0
        mov     ecx, 0		; initialize ecx with 0

.multiplyLoop:
        xor     ebx, ebx	; set to 0, same as 'mov  ebx, 0'
        mov     bl, [esi+ecx]	; move a single into ebx lower half
        cmp     bl, 48		; compare ebx lower half value against ascii '0'
        jl      .finished	; jump if less
        cmp     bl, 57		; compare ebx lower half value against ascii '9'
        jg      .finished	; jump if greater

        sub     bl, 48		; convert to ascii, substract ascii value of '0'
        add     eax, ebx	; add ebx to eax, out sum
        mov     ebx, 10
        mul     ebx		; multiplyi eax by 10
        inc     ecx		; increment out counter
        jmp     .multiplyLoop	; continue

.finished:
        cmp     ecx, 0		; compare ecx value, our counter against 0
        je      .restore	; jump if no integer argument has been passed to atoi
        mov     ebx, 10
        div     ebx		; divite eax by value in ebx (10)

.restore:
        pop     esi
        pop     edx
        pop     ecx
        pop     ebx
        ret


;--------------------------------
; void iprint(Integer number)
; Integer printing function (itoa)
iprint:
        push    eax             ; preserve these on stack to be restored after function runs
        push    ecx
        push    edx
        push    esi

        mov     ecx, 0          ; counter how many bytes we need to print in the end

divideLoop:
        inc     ecx             ; count each byte to print - number of chars
        mov     edx, 0          ; empty edx
        mov     esi, 10         ; mov 10 into esi
        idiv    esi             ; divide eax by esi

        add     edx, 48         ; conver edx to ascii, edx holds reminder of division
        push    edx             ; push edx (string represenation of integer) onto stack
        cmp     eax, 0          ; can the integer be divided anymore?
        jnz     divideLoop

printLoop:
        dec     ecx             ; count down each bytes that we put on the stack
        mov     eax, esp        ; mov the stack pointer into eax for printing
        call    sprint
        pop     eax             ; remove last char from stack to move esp forward
        cmp     ecx, 0          ; have we printed all bytes that we pushed onto the stack?
        jnz     printLoop       ; jump to printLoop in not zero

        pop     esi             ; restore from stack
        pop     edx             ; ..
        pop     ecx
        pop     eax
        ret


;--------------------------------
; void iprintLF(Integer number)
; Integer printing function with linefeed (itoa)
iprintLF:
        call iprint

        push    eax             ; push eax onto stack to preserve
                                ; while we use the eax register int this funtion
        mov     eax, 0Ah        ; move 0Ah into eax (linefeed)
        push    eax             ; push the linefeed into the stack so we can get the address
        mov     eax, esp        ; mov the address of the current stack pointer into eax for sprint
        call    sprint
        pop     eax             ; remove the linefeed from stac
        pop     eax             ; restore original value of eax from before our function was called
        ret


;--------------------------------
; int slen(String message)
; String len calculation function
slen:
        push    ebx
        mov     ebx, eax

nexchar:
        cmp     byte [eax], 0
        jz      finished
        inc     eax
        jmp     nexchar

finished:
        sub     eax, ebx
        pop     ebx
        ret


;--------------------------------
; void sprint(String message)
; String printing function
sprint:
        push    edx
        push    ecx
        push    ebx
        push    eax
        call    slen

        mov     edx, eax
        pop     eax

                                ;
                                ; ssize_t write(int fd, const void *buf, size_t count)
                                ;
        mov     ecx, eax
        mov     ebx, 1
        mov     eax, 4
        int     80h

        pop     ebx
        pop     ecx
        pop     edx
        ret

;--------------------------------
; void sprint_line(String message)
; String printing function adding linefeed
sprint_line:
        call    sprint

        push    eax
        mov     eax, 0Ah
        push    eax
        mov     eax, esp
        call    sprint
        pop     eax
        pop     eax
        ret


;--------------------------------
; void exit()
; Exit programm and restore resources
quit:

                                ;
                                ; void _exit(int status);
                                ;
        mov     ebx, 0
        mov     eax, 1
        int     80h
        ret
