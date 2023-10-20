org 0x7c00

bits 16

cli
cld

mov bp, 0x7bff
xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, bp

;set serial port
mov ah, 0
mov al, 0b11100011
mov dx, 0

int 0x14

;set video mode
mov ax, 0x13

int 0x10

;load game
xor bx, bx
mov es, bx
mov bx, 0x7e00

mov ah, 0x02
mov al, 2
mov cx, 2 ;ch=0, cl=2
mov dx, 0x80 ;dh=0, dl=80

int 0x13

jmp 0x7e00

hlt

times 510 - ($-$$) db 0
dw 0xaa55
