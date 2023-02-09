; char *index(const char *s, int c);
BITS 64                             ; architecture 64

section .text                       ; coding section

global index                        ; definition of index function
    index:
        xor rax, rax

    .loop:
        cmp byte [rdi], sil         ; compare the string and the char | sil is rsi (second param) but on 8 bytes
        je .is_true                 ; if the comparaison is true
        cmp byte [rdi], 0x0         ; compare the string and the null byte | check if string is over
        je .end_null
        inc rdi                     ; increment the string index
        jmp .loop

    .is_true:
        mov rax, rdi                ; move rdi value into rax => return register
        ret                         ; return rax

    .end_null:
        mov rax, 0x0                ; set return value at null
        ret                         ; return rax
