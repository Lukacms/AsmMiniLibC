; void *memset(void s[.n], int c, size_t n);
; fills the first n bytes of the memory area pointed to by s with the constant byte c.
; s => rdi
; c => rsi
; n => rdx
BITS 64                             ; architecture 64

section .text                       ; coding section

global memset                       ; definition of memset function
    memset:
        xor rax, rax
        mov rcx, 0x0                ; init an index at 0 (xor with itself == 0)

    .loop:
        cmp rcx, rdx                ; check is index is not >= to the size given in param (3rd param)
        je .end                     ; go to end
        mov byte [rdi + rcx], sil   ; set str[ind] to c => sil
        inc rcx                     ; increment the index
        jmp .loop                   ; continue loop

    .end:
        mov rax, rdi                ; put malloced param (1st param) in return register (rax)
        ret                         ; return rax
