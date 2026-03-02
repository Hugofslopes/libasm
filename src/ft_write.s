bits 64
global ft_write
extern __errno_location

section .text

ft_write:
	mov     rax, 1            ; syscall: write
	syscall
	cmp     rax, 0
	jge     .end

	mov     rdi, rax          ; save negative errno
	neg     rdi               ; make positive
	call    __errno_location  ; get &errno
	mov     [rax], edi        ; *errno = error
	mov     rax, -1           ; return -1

.end:
	ret