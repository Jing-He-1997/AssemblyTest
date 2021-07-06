;实验12
;要实现0号中断处理程序，在屏幕中间显示 divide error后返回dos

assume cs:code
code segment

start:
mov ax,cs
mov ds,ax
mov si,offset int0

mov ax,0
mov es,ax
mov di,200h

cli
mov cx,offset int0end - offset int0
cld
rep movsb
sti

mov ax,0
mov es,ax
mov word ptr es:[0*4],200h
mov word ptr es:[0*4+2],0

mov ax,4c00h
int 21h

int0:
jmp short int0start
db 'divide error!'

int0start:
mov ax,cs
mov ds,ax
mov si,202h

mov ax,0b800h
mov es,ax
mov di,160*12+33*2

mov cx,13

s:
mov al,ds:[si]
mov ah,2
mov es:[di],ax
inc si
add di,2
loop s

mov ax,4c00h
int 21h

int0end:
nop

code ends
end start






