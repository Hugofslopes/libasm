bits 64
global ft_strcpy
extern __errno_location

ft_strcpy:
	; Check for NULL pointers using cmp + je
	cmp rdi, 0
	je .null_pointer
	cmp rsi, 0
	je .null_pointer

	mov rax, rdi            ; Save return value (dest)

.copy_loop:
	mov bl, byte [rsi]      ; Load current byte from src
	mov byte [rdi], bl      ; Store it in dest
	inc rsi
	inc rdi
	cmp bl, 0
	jne .copy_loop

	ret

.null_pointer:
	; Set errno = EFAULT (bad address)
	mov edi, 14             ; EFAULT
	call __errno_location
	mov dword [rax], edi
	xor rax, rax            ; Return NULL
	ret