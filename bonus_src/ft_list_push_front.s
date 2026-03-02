bits 64
global ft_list_push_front
extern __errno_location
extern malloc

section .text

; void ft_list_push_front(t_list **begin_list, void *data)
; rdi = begin_list
; rsi = data

ft_list_push_front:
	cmp rdi, 0
	je .invalid_list

	mov r8, rdi
	mov r9, rsi

	mov rdi, 16
	call malloc
	test rax, rax
	je .malloc_fail

	mov [rax], r9
	mov rcx, [r8]
	mov [rax + 8], rcx
	mov [r8], rax
	ret

.invalid_list:
	mov edi, 14
	call __errno_location
	mov dword [rax], edi
	ret

.malloc_fail:
	ret
