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
	call	sprint

	push	eax
	mov	eax, 0Ah
	push	eax
	mov	eax, esp
	call	sprint
	pop	eax
	pop	eax
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
