bits 64
global ft_list_sort

section .text

; void ft_list_sort(t_list **begin_list, int (*cmp)(void *, void *))
; rdi = begin_list (pointer to head)
; rsi = cmp function pointer
; cmp returns: negative if a<b, 0 if a==b, positive if a>b

ft_list_sort:
	cmp rdi, 0
	je .done
	cmp rsi, 0
	je .done

	mov r8, rdi        ; r8 = begin_list pointer
	mov r9, rsi        ; r9 = cmp function pointer

.outer_loop:
	mov r10, [r8]      ; r10 = current head
	test r10, r10
	je .done

	xor r11d, r11d     ; r11d = swapped flag
	mov r12, [r8]      ; r12 = traverse pointer

.inner_loop:
	mov rax, r12       ; rax = current node
	mov rcx, [rax + 8] ; rcx = next node
	test rcx, rcx
	je .outer_check    ; if no next, done with this pass

	; Save registers that will be clobbered by cmp call
	mov rdi, [rax]     ; rdi = current->data (arg 1)
	mov rsi, [rcx]     ; rsi = next->data (arg 2)
	call r9            ; call cmp function

	test eax, eax
	jle .no_swap       ; if cmp <= 0, no swap needed

	; Swap data pointers between nodes
	mov rdx, [r12]     ; rdx = current->data
	mov r13, [rcx]     ; r13 = next->data
	mov [r12], r13     ; current->data = next->data
	mov [rcx], rdx     ; next->data = current->data
	mov r11d, 1        ; swapped = 1

.no_swap:
	mov r12, [r12 + 8] ; r12 = r12->next
	jmp .inner_loop

.outer_check:
	test r11d, r11d
	jne .outer_loop     ; if swapped, do another pass

.done:
	ret


