; size_t strcspn(const char *s, const char *reject);
; calculates the length of the initial segment of s which consists entirely of bytes not in reject.
; s => rdi
; reject => rsi
BITS 64                             ; architecture 64

section .text                       ; coding section

global strcspn                      ; definition of strcspn function
    strcspn:
        xor rax, rax                ; convention => init rax (return value) to 0
        mov rcx, 0x0                ; init index that will go through haystack
        mov r8, 0x0                 ; init temporary register for s[rcx]
        mov r9, 0x0                 ; index to go through reject

    .loop:
        mov r9, 0x0                 ; reset index at 0
        mov r8b, byte [rdi + rcx]   ; move byte in temp register
        cmp r8b, 0x0                ; see if it's the end of the string
        je .end                     ; go to end if it is
        jmp .search_reject

    .search_reject:
        cmp byte [rsi + r9], 0x0    ; see if end of reject, in which case found good byte
        je .end
        cmp r8b, byte [rsi + r9]    ; see if s[rcx] and reject[r9] are equal
        je .back_to_loop            ; go back to loop if equal
        inc r9                      ; increment r9 index
        jmp .search_reject          ; continue loop

    .back_to_loop:
        inc rcx                     ; increment rcx
        jmp .loop

    .end:
        mov rax, rcx                ; set return value to the index
        ret
