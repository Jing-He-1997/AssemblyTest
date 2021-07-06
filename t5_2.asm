;实验5.3
;编写code段的代码，将a段和b段中的数据依次相加，将结果存到c段中。

assume cs:code

a segment
db 1,2,3,4,5,6,7,8
a ends

b segment
db 1,2,3,4,5,6,7,8
b ends

c segment
db 8 dup (0)
c ends

code segment
start:
mov ax,a
mov ds,ax

mov si,0

mov cx,8

s:
mov al,ds:[si]
add al,ds:16[si]
mov ds:32[si],al ;通过debug可知 a,b,c段各占16个字节
inc si
loop s

mov ax,4c00h
int 21h

code ends
end start
