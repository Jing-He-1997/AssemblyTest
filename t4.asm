;实验4.1
;向内存0:200-0:23f传递数据0-63，程序中只能使用9条指令
assume cs:code

code segment
start:
mov ax,20h
mov ds,ax
mov bx,0
mov cx,64

s:
mov [bx],bx
inc bx
loop s

mov ax,4c00h
int 21h

code ends
end start

