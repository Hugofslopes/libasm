bits 64
global ft_read
extern __errno_location

section .text

ft_read:
	mov     rax, 0          ; syscall: read
	syscall

	cmp     rax, 0
	jge     .end            ; if rax >= 0, success

	; error case
	mov     rdi, rax        ; rdi = negative errno
	neg     rdi             ; make it positive
	call    __errno_location
	mov     [rax], edi      ; *errno = error
	mov     rax, -1         ; return -1

.end:
	ret