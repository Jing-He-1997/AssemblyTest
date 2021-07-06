assume cs:code

code segment
start:
mov ax,4e20h
add ax,1416h
mov bx,2000h
add ax,bx
mov bx,ax
add ax,bx
mov ax,001ah
mov bx,0026h
add al,bl
add ah,bl
add bh,al
mov ah,0
add al,bl
add al,9ch

mov ax,4c00h
int 21h

code ends
end start