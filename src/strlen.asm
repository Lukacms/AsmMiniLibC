BITS 64                             ; architecture 64

section .text                       ; coding section

global _strlen                      ; strlen function_strlen
    _strlen:
    xor rax, rax                    ; => int i = 0 in c

    .loop:
        cmp byte [rdi + rax], 0x0         ; see if the index is null
        je .end                     ; go to the end
        inc rax                     ; increment the index
        jmp .loop                   ; continue the loop

    .end:
        ret                         ; return the final index
