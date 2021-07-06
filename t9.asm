;实验9（故意出错）
;在屏幕中间分别显示绿色、绿底红色、白底蓝色

assume cs:code,ds:data,ss:stack

data segment
db 'Welcome to masm!'
data ends

stack segment
db 16 dup (0)
stack ends

code segment
start:
mov ax,data
mov ds,ax
mov bx,0

call show_str

mov ax,4c00h
int 21h

show_str:
mov ax,0b800h
mov es,ax
mov di,0

push bx 
push di ;压栈1
mov cx,16
s1:
mov al,ds:[bx]
mov ah,00000010b
mov es:[di],ax
add di,2
inc bx
loop s1

pop di
pop bx ;出栈1

push bx
push di ;压栈2
mov cx,16
s2:
mov al,ds:[bx]
mov ah,10101100b
mov es:160[di],ax
add di,2
inc bx
loop s2

pop di
pop bx ;出栈2

push bx
push di ;压栈3后没出栈
mov cx,16
s3:
mov al,ds:[bx]
mov ah,11111001b
mov es:320[di],ax
add di,2
inc bx
loop s3

ret ;返回时值发生变化

code ends
end start



