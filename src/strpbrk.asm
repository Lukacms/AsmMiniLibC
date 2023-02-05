; char *strpbrk(const char *s, const char *accept);
; locates the first occurrence in the string s of any of the bytes in the string accept.
; s => rdi
; accept => rsi
BITS 64                             ; architecture 64

section .text                       ; coding section

global strpbrk                       ; definition of strpbrk function
    strpbrk:
        xor rax, rax                ; convention => init rax (return value) to 0
        mov rcx, 0x0                ; init index that will go through haystack
        mov r8, 0x0                 ; init temporary register for s[rcx]
        mov r9, 0x0                 ; index to go through accept

    .loop:
        mov r9, 0x0                 ; reset index at 0
        mov r8b, byte [rdi + rcx]   ; move byte in temp register
        cmp r8b, 0x0                ; see if it's the end of the string
        je .end_null                ; return null if it is
        jmp .search_accept

    .search_accept:
        cmp byte [rsi + r9], 0x0    ; see if end of accept
        je .back_to_loop
        cmp r8b, byte [rsi + r9]    ; see if s[rcx] and accept[r9] are equal
        je .end_found               ; go to end if found
        inc r9                      ; increment r9 index
        jmp .search_accept          ; continue loop

    .back_to_loop:
        inc rcx                     ; increment rcx
        jmp .loop

    .end_null:
        mov rax, 0x0                ; set return value to null
        ret

    .end_found:
        mov rax, rdi                ; set the return value to haystack + ind
        add rax, rcx                ; add the index
        ret
