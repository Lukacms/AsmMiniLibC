; int strcasecmp(const char *s1, const char *s2);
; s1 => rdi
; s2 => rsi
BITS 64                             ; architecture 64

section .text                       ; coding section

global strcasecmp                   ; definition of strcasecmp function
    strcasecmp:
        xor rax, rax                ; init rax at 0
        mov rcx, 0x0                ; init ind
        mov r8, 0x0
        mov r9, 0x0

    .loop:
        cmp byte [rdi + rcx], 0x0   ; see if first str is finished
        je .end
        cmp byte [rsi + rcx], 0x0   ; see if second str is finished
        je .end
        mov r8b, byte [rdi + rcx]   ; move s1[rcx] in temp register
        mov r9b, byte [rsi + rcx]   ; move s2[rcx] in temp register
        cmp r8b, 'A'
        jge .is_first_higher_letter
        jmp .compare

    .is_first_higher_letter:
        cmp r8b, 'Z'
        jbe .is_second_lower
        jmp .is_first_lower

    .is_first_lower:
        cmp r8b, 'a'
        jge .is_first_lower_contained
        jmp .compare

    .is_first_lower_contained:
        cmp r8b, 'z'
        jbe .is_second_higher
        jmp .compare

    .is_second_lower:
        cmp r9b, 'a'
        jge .is_second_lower_contained
        jmp .compare

    .is_second_lower_contained:
        cmp r9b, 'z'
        jbe .second_to_uppercase
        jmp .compare

    .second_to_uppercase:
        sub r9b, 32
        jmp .compare

    .is_second_higher:
        cmp r9b, 'A'
        jge .is_second_higher_contained
        jmp .compare

    .is_second_higher_contained:
        cmp r9b, 'Z'
        jbe .second_to_lowercase
        jmp .compare

    .second_to_lowercase:
        add r9b, 32
        jmp .compare

    .compare:
        cmp r8b, r9b
        jne .end
        inc rcx
        jmp .loop

    .end:
        sub r8, r9
        mov rax, r8
        ret
