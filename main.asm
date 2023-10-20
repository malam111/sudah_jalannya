mov bp, 0x7e00
push bp

mov ax, 0xa000
mov es, ax
mov di, 0

mov ax, 0xa000
mov al, 0x0f
stosb

mov bx, 0x524
mov si, bx
mov ax, [0x24]
mov [si], ax
mov ax, [0x24+2]
mov [si+2], ax

mov ax, keyboard_handler
add ax, bp
mov di, 0x24
mov WORD [di], ax
mov WORD [di+2], cs

sti

jmp main

;data
msg db "Hello World!", 0
x_ctr db "a", 0 
y_ctr db "a", 0

main:
mov bx, bp
add bx, msg
push bx
call print

idle:
jmp idle


%include "print.asm"
%include "input.asm"
