;实验6.2
;将data段中的每个单词改为大写字母

assume cs:code,ds:data

data segment
db 'ibm             '
db 'dec             '
db 'dos             '
db 'vax             '
data ends

code segment
start:

mov ax,data
mov ds,ax
mov bx,0

mov cx,4

s0:

push cx

mov si,0
mov cx,3

s1:
and byte ptr ds:[bx+si],11011111b ;一个字符占一个字节
inc si
loop s1

pop cx
add bx,16 ;要记住换行
loop s0

mov ax,4c00h
int 21h

code ends
end start
