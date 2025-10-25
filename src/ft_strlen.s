global ft_strlen

section .text
ft_strlen:
    push    rbp            ; Save base pointer
    mov     rbp, rsp       ; Set up new base pointer
    mov     rax, 0         ; Initialize counter to 0
    mov     rcx, rdi       ; Move string pointer to rcx

count_loop:
    cmp     byte [rcx], 0  ; Compare current byte with null terminator
    je      end            ; If equal (found null), jump to end
    inc     rax            ; Increment counter
    inc     rcx            ; Move to next character
    jmp     count_loop     ; Continue loop

end:
    mov     rsp, rbp       ; Restore stack pointer
    pop     rbp            ; Restore base pointer
    ret                    ; Return (length is in rax)