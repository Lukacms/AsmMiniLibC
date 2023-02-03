BITS 64                             ; architecture 64

section .text                       ; coding section

global strcmp                       ; definition of strcmp function
    strcmp:
    xor rax, rax                    ; init the return value
    mov rcx, 0x0

    .loop:
        cmp byte [rdi + rcx], 0x0   ; see if first str is finished
        je .end
        cmp byte [rsi + rcx], 0x0   ; see if second str is finished
        je .end
        mov r8, [rsi + rcx]
        cmp byte [rdi + rcx], r8b
        jne .end
        inc rcx
        jmp .loop

    .end:
        mov r8, [rdi + rcx]
        mov r9, [rsi + rcx]
        sub r8, r9
        mov rax, r8
        ret                         ; return rax
