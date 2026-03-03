global ft_list_remove_if

section .text

; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)());
; rdi = begin_list (pointer to pointer to first element)
; rsi = data_ref
; rdx = cmp
; rcx = free_fct

ft_list_remove_if:
    push rbp
    mov rbp, rsp
    push rbx             ; current node pointer

    ; save arguments in non-volatile registers
    mov r12, rdi         ; r12 = begin_list
    mov r13, rsi         ; r13 = data_ref
    mov r14, rdx         ; r14 = cmp
    mov r15, rcx         ; r15 = free_fct

    ; Check if begin_list or *begin_list is NULL
    test r12, r12
    je .done
    mov rax, [r12]
    test rax, rax
    je .done

; -------------------------------
; Remove matching nodes at the head
.loop_head:
    mov rax, [r12]        ; rax = *begin_list
    test rax, rax
    je .done

    ; Call cmp((*begin_list)->data, data_ref)
    mov rdi, [rax]        ; rdi = (*begin_list)->data
    mov rsi, r13          ; rsi = data_ref
    call r14              ; cmp function
    test eax, eax
    jne .loop_body         ; if not 0, stop removing head

    ; Remove head node
    mov rbx, [r12]        ; rbx = node to remove
    mov rax, [rbx + 8]    ; rax = node->next
    mov [r12], rax        ; *begin_list = node->next

    ; Free node data if free_fct exists
    test r15, r15
    je .skip_free_head
    mov rdi, [rbx]        ; rdi = node->data
    call r15

.skip_free_head:
    ; Free the node itself using free_fct
    test r15, r15
    je .loop_head
    mov rdi, rbx
    call r15

    jmp .loop_head

; -------------------------------
.loop_body:
    mov rbx, [r12]        ; rbx = current node
    test rbx, rbx
    je .done

.loop:
    mov rax, [rbx + 8]     ; rax = current->next
    test rax, rax
    je .done

    ; Call cmp(current->next->data, data_ref)
    mov rdi, [rax]         ; rdi = current->next->data
    mov rsi, r13           ; rsi = data_ref
    call r14               ; cmp
    test eax, eax
    jne .next_node          ; if not 0, move to next

    ; Remove current->next
    mov rdi, [rax + 8]     ; rdi = current->next->next
    mov [rbx + 8], rdi     ; current->next = current->next->next

    ; Free node data if free_fct exists
    test r15, r15
    je .skip_free_body
    mov rdi, [rax]         ; rdi = node->data
    call r15

.skip_free_body:
    ; Free node itself using free_fct
    test r15, r15
    je .loop
    mov rdi, rax
    call r15

    jmp .loop

.next_node:
    mov rbx, [rbx + 8]     ; advance current = current->next
    jmp .loop

; -------------------------------
.done:
    pop rbx
    pop rbp
    ret