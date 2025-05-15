section .data
inputBuf: db 0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A
inputLen  equ 8
hexChars: db '0123456789ABCDEF'

section .bss
outputBuf: resb 80

section .text
global _start

_start:
    mov esi, inputBuf
    mov edi, outputBuf
    mov ecx, inputLen

process_loop:
    lodsb
    push ecx
    mov ah, al
    shr ah, 4
    mov al, ah
    call convert_to_ascii
    mov [edi], al
    inc edi

    mov al, [esi - 1]
    and al, 0x0F
    call convert_to_ascii
    mov [edi], al
    inc edi

    mov byte [edi], ' '
    inc edi

    pop ecx
    loop process_loop

    dec edi
    mov byte [edi], 0xA

    mov eax, 4
    mov ebx, 1
    mov ecx, outputBuf
    sub edi, outputBuf
    mov edx, edi
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80

convert_to_ascii:
    and al, 0x0F
    movzx eax, al
    mov al, [hexChars + eax]
    ret
