bits 64
global ft_strcmp
extern __errno_location

ft_strcmp:
	; Check for NULL pointers using cmp + je
	cmp rdi, 0
	je .null_pointer
	cmp rsi, 0
	je .null_pointer

.compare_loop:
	mov al, [rdi]      ; Load byte from first string
	mov bl, [rsi]      ; Load byte from second string
	cmp al, bl          ; Compare the two bytes
	jne .done           ; If different, return the difference
	cmp al, 0
	je .done            ; If null terminator, strings are equal

	inc rdi             ; Move first string pointer
	inc rsi             ; Move second string pointer
	jmp .compare_loop

.null_pointer:
	; Set errno = EFAULT (bad address)
	mov edi, 14         ; EFAULT
	call __errno_location
	mov dword [rax], edi
	xor rax, rax        ; Return 0
	ret

.done:
	movzx rax, al       ; Zero extend first byte to rax
	movzx rbx, bl       ; Zero extend second byte to rbx
	sub rax, rbx        ; rax = s1[i] - s2[i]
	ret