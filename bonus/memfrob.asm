; void *memfrob(void s[.n], size_t n);
; obfuscates the first n bytes of the memory area s by exclusive-ORing each character with the number 42.
; s => rdi
; n => rsi
BITS 64                             ; architecture 64

section .text                       ; coding section

global memfrob                      ; definition of memfrob
    memfrob:
        xor rax, rax                ; convention => return value to 0
        xor rcx, rcx                ; init index to go through s

    .loop:
        cmp rcx, rsi
        je .end
        cmp byte [rdi + rcx], 0x0
        je .end
        xor byte [rdi + rcx], 42

    .end:
        mov rax, rdi
        ret
