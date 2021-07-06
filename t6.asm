;实验6.1
;data中第一个字符串转化为大写，第二个转化为小写

assume cs:code,ds:data

data segment
a db 'BaSiC'
b db 'iNfOrMaTiOn'
data ends

code segment
start:
mov ax,data
mov ds,ax

mov bx,0
mov cx,5

s1:
and a[bx],11011111b ;大写 从0开始的第5位为0
inc bx
loop s1

mov bx,0
mov cx,10

s2:
or b[bx],00100000b ;小写 从0开始的第5位为1
inc bx
loop s2

mov ax,4c00h
int 21h

code ends
end start