;实验13.1
;编写并安装int 7ch中断例程，功能为显示一个用0结尾的字符串，中断例程安装在0：200处。
assume cs:code
code segment
start:

mov ax,cs
mov ds,ax
mov si,offset int7ch

mov ax,0
mov es,ax
mov di,200h

mov cx,offset int7chends - offset int7ch
cld
rep movsb

mov ax,0
mov es,ax
mov word ptr es:[7ch*4],200h
mov word ptr es:[7ch*4+2],0

mov ax,4c00h
int 21h

int7ch:
mov ax,0b800h
mov es,ax
mov di,0

mov ah,0
mov al,160
dec dh
mul dh

mov bx,ax

mov ah,0
mov al,dl
add al,al
add bx,ax

mov al,cl

int7ch_copy:
mov ch,0
mov cl,[si]
jcxz int7ch_over
mov es:[bx+di],cl
mov es:[bx+di+1],al
inc si
add di,2
jmp short int7ch_copy

int7ch_over:
iret

int7chends:
nop

code ends
end start