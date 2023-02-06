; char *strncpy(char *restrict dst, const char *restrict src, size_t sz);
; copy  the string pointed to by src, into a string at the buffer pointed to by dst.
; return pointer to dst
; dst => rdi
; src => rsi
; sz => rdx
BITS 64                             ; architecture 64

section .text                       ; coding section

extern strlen                       ; strlen prototype

global strncpy                       ; definition of strncpy
    strncpy:
        xor rax, rax                ; init return value (convention)
        mov rcx, 0x0                ; init index
        mov r8, 0x0                 ; init temporary register at 0

    .loop:
        cmp rdx, rcx
        je .end
        cmp byte [rsi + rcx], 0x0   ; check if src is over
        je .end
        mov r8b, byte [rsi + rcx]   ; move src[rcx] in temp register
        mov byte [rdi + rcx], r8b   ; assign dst[rcx] to src[rcx] through tmp
        inc rcx                     ; increment index
        jmp .loop

    .end:
        mov rax, rdi                ; set return value to dest
        ret
