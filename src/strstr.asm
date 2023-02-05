; char *strstr(const char *haystack, const char *needle);
; finds the first occurrence of the substring needle in the string haystack.
; haystack => rdi
; needle => rsi
BITS 64                             ; architecture 64

section .text                       ; coding section

global strstr                       ; definition of strstr function
    strstr:
        xor rax, rax                ; convention => init rax (return value) to 0
        mov rcx, 0x0                ; init index that will go through haystack
        mov r8, 0x0                 ; init temporary index to go through needle
        mov r9, 0x0                 ; init tmp register to compare
        ; check if needle is empty, in chich case we return a pointer to the beginning of haystack
        cmp rsi, 0x0
        je .end_null
        jmp .loop

    .loop:
        cmp byte [rdi + rcx], 0x0
        je .end_null
        mov r8, 0x0
        jmp .compare_from_ind

    .compare_from_ind:
        cmp byte [rsi + r8], 0x0
        je .end_found
        cmp byte [rdi + rcx + r8], 0x0
        je .end_null
        mov r9b, byte [rdi + rcx + r8]
        cmp byte [rsi + r8], r9b
        je .compare_from_ind
        inc rcx
        jump .loop

    .end_null:
        mov rax, rdi                ; set return value to beginning of haystack
        ret

    .end_not_found:
        mov rax, 0x0                ; set return value to null
        ret

    .end_found:
        mov rax, rdi + rcx          ; set the return value to haystack + ind
        ret
