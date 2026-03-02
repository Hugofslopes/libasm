bits 64
global ft_list_size

section .text
; int ft_list_size(t_list *begin_list)

ft_list_size:
	xor eax, eax
	test rdi, rdi
	je .done

	mov r8, rdi       ; save first node

.loop:
	inc eax           ; increment counter
	mov rdi, [rdi + 8] ; move to next
	test rdi, rdi     ; check if NULL (end of list)
	je .done
	cmp rdi, r8       ; check if back to first node (circular)
	je .done
	jmp .loop

.done:
	ret
