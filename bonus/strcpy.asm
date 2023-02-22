; char *strcpy(char *restrict dst, const char *restrict src);
; copy  the string pointed to by src, into a string at the buffer pointed to by dst.
; return pointer to dst
; dst => rdi
; src => rsi
BITS 64                             ; architecture 64

section .text                       ; coding section

global strcpy                       ; definition of strcpy
    strcpy:
        xor rax, rax                ; init return value (convention)
        mov rcx, 0x0                ; init index
        mov r8, 0x0                 ; init temporary register at 0

    .loop:
        cmp byte [rsi + rcx], 0x0   ; check if src is over
        je .end
        mov r8b, byte [rsi + rcx]   ; move src[rcx] in temp register
        mov byte [rdi + rcx], r8b   ; assign dst[rcx] to src[rcx] through tmp
        inc rcx                     ; increment index
        jmp .loop

    .end:
        mov rax, rdi                ; set return value to dest
        ret
