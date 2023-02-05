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
        cmp byte [rdi + rcx], 0x0       ; see if first str is finished
        je .end
        cmp byte [rsi + rcx], 0x0       ; see if second str is finished
        je .end
        mov r8b, byte [rdi + rcx]       ; move s1[rcx] in temp register to not modify it
        mov r9b, byte [rsi + rcx]       ; move s2[rcx] in temp register to not modify it
        cmp r8b, 'A'                    ; see if s1[rcx] can be a letter
        jge .is_first_higher_letter     ; check if it's possible
        jmp .compare                    ; if not, just compare both chars

    .is_first_higher_letter:            ; check if s1[rcx] is between 'A' and 'Z'
        cmp r8b, 'Z'
        jbe .is_second_lower            ; if yes, check if s2[rcx] is between 'a' and 'z' => would have to put it in uppercase if yes
        jmp .is_first_lower             ; if no, check if s1[rcx] is between 'a' and 'z'

    .is_first_lower:                    ; check if s1[rcx] > 'a'
        cmp r8b, 'a'
        jge .is_first_lower_contained   ; if yes, check if < 'z'
        jmp .compare                    ; if no, can't be alphabetic and just compare both chars

    .is_first_lower_contained:          ; check if s1[rcx] between 'a' and 'z'
        cmp r8b, 'z'
        jbe .is_second_higher           ; if yes, check if s2[rcx] is uppercase => would have to put in lowercase if yes
        jmp .compare                    ; if not, not alphabetic so just compare chars

    .is_second_lower:                   ; check if s2[rcx] is lower, in wich case it would be put in uppercase
        cmp r9b, 'a'
        jge .is_second_lower_contained  ; if s2[rcx] > 'a', check if < 'z'
        jmp .compare                    ; if not, compare

    .is_second_lower_contained:         ; check if s2[rcx] < 'z'
        cmp r9b, 'z'
        jbe .second_to_uppercase        ; if yes, transform to uppercase
        jmp .compare                    ; not, compare

    .second_to_uppercase:
        sub r9b, 32                     ; transform to uppercase, 'A' - 'a' = -32 in ascii
        jmp .compare

    .is_second_higher:                  ; check if s2[rcx] is uppercase
        cmp r9b, 'A'
        jge .is_second_higher_contained ; if > 'A', check if < 'Z'
        jmp .compare

    .is_second_higher_contained:        ; check if s2[rcx] < 'Z'
        cmp r9b, 'Z'
        jbe .second_to_lowercase        ; if yes, transform to lowercase
        jmp .compare

    .second_to_lowercase:
        add r9b, 32                     ; 'a' - 'A' = 32 in ascii
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
