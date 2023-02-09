; int strcasecmp(const char *s1, const char *s2);
; s1 => rdi
; s2 => rsi
BITS 64                                 ; architecture 64

section .text                           ; coding section

global strcasecmp                       ; definition of strcasecmp function
    strcasecmp:
        xor rax, rax                    ; init rax at 0
        mov rcx, 0x0                    ; init ind => rcx register because not used with function params
        mov r8, 0x0                     ; IMPORTANT => init both tmp registers at 0
        mov r9, 0x0                     ; because they are on 64 bits and only 8 of them will be used in the comparaison

    .loop:
        mov r8b, byte [rdi + rcx]       ; move s1[rcx] in temp register to not modify it
        mov r9b, byte [rsi + rcx]       ; move s2[rcx] in temp register to not modify it
        cmp byte [rdi + rcx], 0x0       ; see if first str is finished
        je .end
        cmp byte [rsi + rcx], 0x0       ; see if second str is finished
        je .end
        cmp r8b, 'A'                    ; see if s1[rcx] can be a letter
        jge .is_first_higher_letter     ; check if it's possible
        jmp .compare                    ; if not, just compare both chars

    .is_first_higher_letter:            ; check if s1[rcx] is between 'A' and 'Z'
        cmp r8b, 'Z'
        jbe .to_lowercase_first         ; if yes, check if s2[rcx] is between 'a' and 'z' => would have to put it in uppercase if yes
        jmp .check_second               ; if no, check if s1[rcx] is between 'a' and 'z'

    .to_lowercase_first:
        add r8b, 32
        jmp .check_second

    .check_second:
        cmp r9b, 'A'
        jge .check_encapsulate
        jmp .compare

    .check_encapsulate:
        cmp r9b, 'Z'
        jbe .to_lowercase_second
        jmp .compare

    .to_lowercase_second:
        add r9b, 32
        jmp .compare

    .compare:
        cmp r8b, r9b                    ; compare both characters, which are obligatory the same case (or not alphabetic) now
        jne .end                        ; if not, end the loop
        inc rcx                         ; if yes, increment the index and go back to the loop
        jmp .loop

    .end:
        sub r8, r9                      ; at the end of the loop (end of s1 / s2) or differencies, sub temp indexes
        mov rax, r8                     ; move the result in return value
        ret
