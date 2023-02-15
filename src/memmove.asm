; void *memmove(void *dest, void *src, size_t n);
; dest -> value to set
; src -> value that dest is gonna be
; n -> size of buffer
BITS 64                             ; architecture 64

section .text                       ; coding section

extern memcpy

global memmove
    memmove:
        xor rax, rax                    ; init return value to 0
        mov rcx, rdi                    ; put first param (dest) in temp register
        sub rcx, rsi                    ; substract dest address with src one
        cmp rcx, rdx                    ; compare the result with n => if <, it means that src and dest overlap in memory
        jge .end_memcpy                 ; if greater, just execute a "classic" memcpy
        mov r9, rdx
        jmp .other                      ; if not, do an "inversed" memcpy (start by the end instead of beginning)

    .end_memcpy:
        call memcpy wrt ..plt           ; call memcpy on rax (-> return value)
        ret                             ; return rax

    .other:
        mov r8b, byte [rsi - 1 + r9]    ; put src[n] to temp register
        mov byte [rdi - 1 + r9], r8b    ; put dest[n] at src[n]
        cmp r9, 0x0                     ; see if size given in param is <= 0
        je .end_other                   ; go to end
        dec r9                          ; decrement n
        jmp .other                      ; go back to loop

    .end_other:
        mov rax, rdi                    ; move dest to return value
        ret                             ; return rax
