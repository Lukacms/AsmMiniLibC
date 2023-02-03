BITS 64                             ; architecture 64

section .text                       ; coding section

global strcmp                       ; definition of strcmp function
    strcmp:
    xor rax, rax                    ; init the return value

    .loop:
        cmp byte [rdi], 0x0
        je .end
        cmp byte [rsi], 0x0
        je .end
        cmp [rsi], [rdi]
        jne .end
        inc rdi
        inc rsi
        jmp .loop

    .end:
        sub [rdi], [rsi]
        mov rax, rdi
        ret                         ; return rax
