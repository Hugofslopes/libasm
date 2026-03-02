bits 64
global ft_atoi_base
extern __errno_location

section .text

; int ft_atoi_base(const char *str, int base)
; rdi = str (const char *)
; rsi = base (int, 2-36)
; Returns: converted integer in rax
; Sets errno on invalid input

ft_atoi_base:
	; Validate base (must be 2-36)
	cmp rsi, 2
	jl .invalid_base
	cmp rsi, 36
	jg .invalid_base

	; Check for NULL str
	cmp rdi, 0
	je .invalid_str

	xor rax, rax        ; result = 0
	xor r8, r8          ; current character index

.loop:
	movzx rcx, byte [rdi + r8]  ; Load current character
	
	; Check for null terminator
	cmp cl, 0
	je .done

	; Skip whitespace (space, tab, newline, etc)
	cmp cl, ' '
	je .next_char
	cmp cl, 9           ; tab
	je .next_char
	cmp cl, 10          ; newline
	je .next_char
	cmp cl, 13          ; carriage return
	je .next_char

	; Convert character to digit value
	; Handle digits 0-9
	cmp cl, '0'
	jl .check_upper
	cmp cl, '9'
	jg .check_upper
	sub cl, '0'
	jmp .validate_digit

.check_upper:
	; Handle uppercase A-Z
	cmp cl, 'A'
	jl .check_lower
	cmp cl, 'Z'
	jg .check_lower
	sub cl, 'A'
	add cl, 10
	jmp .validate_digit

.check_lower:
	; Handle lowercase a-z
	cmp cl, 'a'
	jl .invalid_char
	cmp cl, 'z'
	jg .invalid_char
	sub cl, 'a'
	add cl, 10

.validate_digit:
	; Check if digit value is valid for the base
	cmp cl, sil         ; Compare digit value with base
	jge .invalid_char

	; Accumulate: result = result * base + digit
	imul rax, rsi       ; result *= base
	movzx rcx, cl       ; Zero extend digit to 64-bit
	add rax, rcx        ; result += digit

.next_char:
	inc r8
	jmp .loop

.done:
	; Clear errno on success
	call __errno_location
	mov dword [rax], 0
	ret

.invalid_base:
	; Set errno = EINVAL (22)
	mov edi, 22
	call __errno_location
	mov dword [rax], edi
	xor rax, rax
	ret

.invalid_str:
	; Set errno = EFAULT (14)
	mov edi, 14
	call __errno_location
	mov dword [rax], edi
	xor rax, rax
	ret

.invalid_char:
	; Set errno = EINVAL (22) - invalid character for base
	mov edi, 22
	call __errno_location
	mov dword [rax], edi
	xor rax, rax
	ret