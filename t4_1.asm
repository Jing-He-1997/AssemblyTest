;实验4.2
;将mov ax,4c00h之前的指令复制到内存0:200处

assume cs:code
code segment
start:
mov ax,cs
mov ds,ax

mov ax,20h
mov es,ax
mov si,0

mov cx,offset startend -offset start

s:
mov al,ds:[si]
mov es:[si],al
inc si
loop s

startend:
mov ax,4c00h
int 21h

code ends
end start

