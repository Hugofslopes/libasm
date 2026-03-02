bits 64
global ft_strlen
extern __errno_location

ft_strlen:
	; Check for NULL pointer
	cmp rdi, 0
	je .null_pointer

	mov rax, 0         ; Initialize counter to 0

.count_loop:
	cmp byte [rdi], 0  ; Compare current byte with null terminator
	je .end
	inc rax             ; Increment counter
	inc rdi
	jmp .count_loop

.null_pointer:
	; Set errno = EFAULT (bad address)
	mov edi, 14         ; EFAULT
	call __errno_location
	mov dword [rax], edi
	xor rax, rax        ; Return 0
	ret

.end:
	ret