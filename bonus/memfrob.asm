; void *memfrob(void s[.n], size_t n);
; obfuscates the first n bytes of the memory area s by exclusive-ORing each character with the number 42.
; s => rdi
; n => rsi
BITS 64                             ; architecture 64

section .text                       ; coding section

global memfrob                      ; definition of memfrob
