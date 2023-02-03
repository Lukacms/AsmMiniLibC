BITS 64                             ; architecture 64

section .text                       ; coding section

global _strchr                      ; definition of strchr function
    _strchr:

    .loop:
        cmp byte [rdi], 0x0         ; compare the string and the null byte | check if string is over
        je .is_true
        cmp byte [rdi], sil         ; compare the string and the char | sil is rsi (second param) but on 8 bytes
        je .is_true                 ; if the comparaison is true
        inc rdi                     ; increment the string index
        jmp .loop

    .is_true:
        mov rax, rdi
        ret
