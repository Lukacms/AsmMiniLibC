BITS 64                             ; architecture 64

section .text                       ; coding section

global memcpy
    memcpy:
        xor rax, rax                ; init return value to 0
        mov rcx, 0x0                ; init index at 0

    .loop:                          ; pointers in string increments at each "turn"
        cmp rcx, rdx                ; check if index is at size (3rd param)
        je .end                     ; go to end
        mov r8, rsi + rcx                 ; move the derefenced index to a temporary register
        mov rdi + rcx, r8                 ; put byte of rdi[rcx] to rdi[rcx] (through r9, tmp)
        inc rcx                     ; increment index
        jmp .loop                   ; continue the loop

    .end:
        mov rax, rdi                ; set the return value to first param
        ret                         ; return rax
