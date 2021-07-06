;实验10.1
;名称：show_str
;功能：在指定的位置，用指定的颜色，显示一个用 0 结束的字符串。
;参数：（dh）= 行号；（dl）= 列号；（cl）= 颜色，ds：si 指向字符串的首地址
;返回：无
;应用举例：在屏幕的 3 行 8 列，用绿色显示 data 段中的字符串。

assume cs:code

data segment
db 'Welcome to masm!',0
data ends

code segment
start:
mov dh,3
mov dl,8
mov cl,2

mov ax,data
mov ds,ax
mov si,0
mov bx,0

call show_str

mov ax,4c00h
int 21h

show_str:
push ax
push cx
push dx
push si
push es


mov ax,0b800h
mov es,ax

mov ah,0
mov al,160
dec dh
mul dh ;行的偏移量

mov bx,ax

mov ax,0
dec dl
mov al,dl
add al,al
add bx,ax ;总偏移量


mov al,cl
mov di,0

s:
mov cl,ds:[si]
mov ch,0
cmp cx,0
je rset
mov es:[bx+di],cl
mov es:[bx+di+1],al
inc si
add di,2
jmp short s

rset:
pop es
pop si
pop dx
pop cx
pop ax
ret

code ends
end start







