;实验10.3
;实现一个子程序，该子程序能将 word 型数据转变为表示十进制数的字符串
;名称：dtoc
;功能：将word型数据转变为表示十进制数的字符串，字符串以10为结尾符。
;参数：(ax)=word型数据,ds:si指向字符串首地址
;返回：无
;应用举例：编程，将数据12666以十进制的形式在屏幕的8行3列，用绿色显示出来。在显示时我们调用本次实验中的第一个子程序show_str.

assume cs:code

data segment
db 10 dup (0)
data ends

code segment
start:
mov ax,data
mov ds,ax
mov si,0

mov ax,317ah

call dtoc

mov dh,8
mov dl,3
mov cl,2

call show_str

mov ax,4c00h
int 21h

dtoc:

mov bx,10
mov ch,0


divdw:
mov dx,0
div bx
mov cx,ax
jcxz over
add dx,30h
mov ds:[si],dl
inc si
jmp short divdw

over:
add dx,30h
mov ds:[si],dl



ret

show_str:
mov ax,0b800h
mov es,ax
mov di,0

mov ah,0
mov al,160
dec dh
mul dh
mov bx,ax

mov ax,0
mov al,dl
add al,al
add bx,ax

mov ah,cl
mov cx,si
inc cx ;循环次数需要+1


s1:
mov al,ds:[si]
mov es:[bx+di],ax
dec si
add di,2
loop s1

ret

code ends
end start



