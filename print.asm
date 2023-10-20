;(si: &str)
print:
mov bp, sp
mov si, [bp+2]
mov bx, si

print_string_loop:
mov al, [bx]
cmp al, 0
je print_exit
push ax

;check for clear2send
print_clear_to_send:
mov ah, 0x03
mov dx, 0

int 0x14

and al, 0b00010000
cmp al, 0b00010000
jne print_clear_to_send

pop ax
mov ah, 1
mov dx, 0
int 0x14

add bx, 1
jmp print_string_loop

print_exit:
ret
