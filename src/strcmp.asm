; int strcmp(const char *s1, const char *s2);
; s1 => rdi
; s2 => rsi
BITS 64                             ; architecture 64

section .text                       ; coding section

global strcmp                       ; definition of strcmp function
    strcmp:
    xor rax, rax                    ; init the return value
    mov rcx, 0x0                    ; init the index
    mov r8, 0x0
    mov r9, 0x0

    .loop:
        cmp byte [rdi + rcx], 0x0   ; see if first str is finished
        je .end
        cmp byte [rsi + rcx], 0x0   ; see if second str is finished
        je .end
        mov r8b, byte [rsi + rcx]   ; set r8 at rsi[rcx]
        cmp byte [rdi + rcx], r8b   ; compare byte of rdi[rcx] and byte of r8 (=> r8b)
        jne .end                    ; go to end if condition not valid
        inc rcx                     ; increment rcx
        jmp .loop                   ; continue loop

    .end:
        mov r8b, byte [rdi + rcx]   ; set r8 to rdi[rcx]
        mov r9b, byte [rsi + rcx]   ; set r9 to rsi[rcx]
        sub r8, r9                  ; => r8 -= r9
        mov rax, r8                 ; set return value to r8
        ret                         ; return rax

; PSA: need to put r8b and not r8 cause it's only byte per byte
