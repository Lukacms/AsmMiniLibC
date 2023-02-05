BITS 64                             ; architecture 64

section .text                       ; coding section

extern strlen                       ; strlen prototype

global strrchr                      ; definition of strchr function
    strrchr:
        xor rax, rax                ; convention => init rax (return value) to 0
        call strlen wrt ..plt       ; appelle la fonction strlen et la met dans rax pour avoir la taille de la string
                                    ; | wrt ..plt => with respect to (plt table); code is position independant

    .loop:
        cmp rax, 0x0                ; compare the index, to see if position is at 0
        je .end_null
        cmp byte [rdi + rax], sil   ; compare the string and the char | sil is rsi (second param) but on 8 bytes
        je .end                     ; if the comparaison is true
        sub rax, 1                  ; decrement the index
        jmp .loop

    .end:
        add rdi, rax                ; add rax to rdi => rdi is gonna point to rdi + rax
        mov rax, rdi                ; move rdi into rax for return value
        ret                         ; return rax

    .end_null:
        mov rax, 0x0                ; set rax at null
        ret                         ; return rax
