bits 64

section .text
    global ft_strdup
    extern malloc
    extern ft_strlen
    extern ft_strcpy
    extern __errno_location

ft_strdup:
    ; Save original string pointer
    mov r8, rdi             ; r8 = original string (s)

    ; Step 1: Calculate length
    mov rdi, rdi
    call ft_strlen
    mov rsi, rax
    inc rsi                 ; length + 1

    ; Step 2: malloc
    mov rdi, rsi
    call malloc
    test rax, rax
    jnz .copy_done

    ; malloc failed → errno = ENOMEM
    mov edi, 12
    call __errno_location
    mov dword [rax], edi
    xor rax, rax
    ret

.copy_done:
    ; Step 3: Copy string
    mov rdi, rax             ; destination
    mov rsi, r8              ; source = original string
    call ft_strcpy

    ; Step 4: Return pointer
    ret