keyboard_handler:
pusha

xor ax, ax
in al, 0x60
mov bl, al
and bl, 0x80
cmp bl, 0
jne keyboard_handler_exit

mov si, 0x7e00
cmp ax, 0x4b
je keyboard_left
cmp ax, 0x4d
je keyboard_right
cmp ax, 0x48
je keyboard_up
cmp ax, 0x50
je keyboard_down

keyboard_cont:
;jmp xy_check
keyboard_cont_2:

in al, 0x61
mov ah, al
or al, 0x80
out 0x61, al
xchg ah, al
out 0x61, al

keyboard_handler_exit:

mov al, 0x20
out 0x20, al

popa

iret

keyboard_left:
	push ax
	add si, x_ctr
	mov ax, [si]
	sub ax, 1
	push WORD "<"
	jmp keyboard_arrow_ret
keyboard_right:
	push ax
	add si, x_ctr
	mov ax, [si]
	add ax, 1
	push WORD ">"
	jmp keyboard_arrow_ret
keyboard_up:
	push ax
	add si, y_ctr
	mov ax, [si]
	add ax, 1
	push WORD "^"
	jmp keyboard_arrow_ret
keyboard_down:
	push ax
	add si, y_ctr
	mov ax, [si]
	sub ax, 1
	push WORD "v"
	jmp keyboard_arrow_ret
keyboard_arrow_ret:
	mov di, si
	mov [di], ax

	pop ax
	mov ah, 1
	mov dx, 0
	int 0x14

	pop ax
	jmp keyboard_cont

keyboard_print:
	add si, 0x7e00
	mov ax, [si]
	mov ah, 1
	mov dx, 0
	int 0x14
	ret

xy_check:
	push ax

	mov si, x_ctr
	call keyboard_print

	mov si, y_ctr
	call keyboard_print

	pop ax
	jmp keyboard_cont_2
