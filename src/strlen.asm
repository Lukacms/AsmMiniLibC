; size_t strlen(const char *s);
; calculates the length of the string pointed to by s, excluding the terminating null byte ('\0').
; s => rdi
BITS 64                             ; architecture 64

section .text                       ; coding section

global strlen                      ; strlen function_strlen
    strlen:
    xor rax, rax                    ; => int i = 0 in c

    .loop:
        cmp byte [rdi + rax], 0x0         ; see if the index is null
        je .end                     ; go to the end
        inc rax                     ; increment the index
        jmp .loop                   ; continue the loop

    .end:
        ret                         ; return the final index, (rdi register)
