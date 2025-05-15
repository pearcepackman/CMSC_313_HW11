section .data
inputBuf: db 0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A
inputLen  equ 8
hexChars: db '0123456789ABCDEF'

section .bss
outputBuf: resb 80

section .text
global _start

_start:
    ; set up pointers and counter
    mov esi, inputBuf
    mov edi, outputBuf
    mov ecx, inputLen

process_loop:
    ; go through each byte in the input
    lodsb
    push ecx

    ; get top half of the byte and convert
    mov ah, al
    shr ah, 4
    mov al, ah
    call convert_to_ascii
    mov [edi], al
    inc edi

    ; get bottom half and convert
    mov al, [esi - 1]
    and al, 0x0F
    call convert_to_ascii
    mov [edi], al
    inc edi

    ; put a space after each byte
    mov byte [edi], ' '
    inc edi

    pop ecx
    loop process_loop

    ; change last space to a newline
    dec edi
    mov byte [edi], 0xA

    ; print the output
    mov eax, 4
    mov ebx, 1
    mov ecx, outputBuf
    sub edi, outputBuf
    mov edx, edi
    int 0x80

    ; exit
    mov eax, 1
    xor ebx, ebx
    int 0x80

; takes a 4-bit value and gives back ascii hex
convert_to_ascii:
    and al, 0x0F
    movzx eax, al
    mov al, [hexChars + eax]
    ret
