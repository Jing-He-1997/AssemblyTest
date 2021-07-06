;实验15
;安装一个新的 int 9 中断例程
;在DOS下，按下’A’键后，除非不再松开，如果松开，就会显示满屏幕的’A’
;其他键的功能照常。

assume cs:code

stack segment
db 129 dup (0)
stack ends

code segment
start:

mov ax,stack
mov ss,ax
mov sp,128

mov ax,cs
mov ds,ax
mov si,offset int9

mov ax,0
mov es,ax
mov di,204h

mov cx,offset int9ends - offset int9
cld
rep movsb

cli
push es:[9*4] ;保存int 9的入口地址
pop es:[200h]
push es:[9*4+2]
pop es:[202h]

mov word ptr es:[9*4],204h ;新的int 9入口地址
mov word ptr es:[9*4+2],0
sti

mov ax,4c00h
int 21h

int9:
push ax
push bx
push cx
push es
push si

in al,60h

pushf
call dword ptr cs:[200h] 
;当我们按键盘按键后，系统引发Int9中断，自动跳到了0:204处执行代码，CS自然等于0了。
;当此中断例程执行时（cs）=0 模拟调用原来的int 9中断例程

cmp al,9fh
je clean

cmp al,9eh
jne go

mov ax,0b800h
mov es,ax
mov si,0
mov cx,2000

s:
mov byte ptr es:[si], 'A'
mov byte ptr es:[si+1],71h
add si,2
loop s
jmp go

clean:
mov ax,0b800h
mov es,ax
mov si,0
mov cx,2000

s1:
mov word ptr es:[si], ''
add si,2
loop s1

go:
pop si
pop es
pop cx
pop bx
pop ax
iret

int9ends:
nop

code ends
end start

