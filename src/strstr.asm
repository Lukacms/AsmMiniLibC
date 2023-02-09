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
        mov r10, 0x0                ; can't have more than 2 registers on a operation
        ; check if needle is empty, in chich case we return a pointer to the beginning of haystack
        cmp byte [rsi], 0x0
        je .end_null
        jmp .loop

    .loop:
        cmp byte [rdi + rcx], 0x0   ; see if haystack[rcx] is null, in which case needle is not in haystack
        je .end_not_found           ; return null
        mov r8, 0x0                 ; reset index to 0
        jmp .compare_from_ind

    .compare_from_ind:
        mov r10, rcx                ; temp index
        add r10, r8                 ; can't do mov r10, rcx + r8 on same line
        cmp byte [rsi + r8], 0x0    ; see if this is the end of needle, in which case needle IS in haystack
        je .end_found
        cmp byte [rdi + r10], 0x0   ; if this is the end of haystack, but not needle, then needle can't be in it cause it's bigger
        je .end_not_found
        mov r9b, byte [rdi + r10]   ; move byte to temporary register to compare
        cmp byte [rsi + r8], r9b    ; compare
        jne .back_to_loop           ; if not equal, increment rcx and continue main loop
        inc r8
        jmp .compare_from_ind       ; if equal, increment r8 and continue loop with needle

    .back_to_loop:
        inc rcx                     ; increment rcx
        jmp .loop

    .end_null:
        mov rax, rdi                ; set return value to beginning of haystack
        ret

    .end_not_found:
        mov rax, 0x0                ; set return value to null
        ret

    .end_found:
        mov rax, rdi                ; set the return value to haystack + ind
        add rax, rcx
        ret
