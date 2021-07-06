;实验14
;以‘年/月/日 时：分：秒’的格式，显示当前的日期、时间
;CMOS RAM中存储着系统的配置信息，除了保存时间信息的单元外，不要向其他的单元中写入内容，否则将引起一些系统错误

assume cs:code
code segment

unit: db 9,8,7,4,2,0
return: dw 0

start:

mov ax,cs
mov ds,ax
mov si,offset unit
mov di,0

;：的ascii码为58
;/的ascii码为47
;空格的ascii码为32
mov cx,6
mov dl,47
show:
mov al,ds:[si]
call show_what ;将数据放入return中
inc si

cmp si,3
je space ;空格

cmp si,4
je hour ;冒号

cmp si,6
je null ;左斜杠

jmp year

null:
mov dl,0
jmp year

space:
mov dl,32
jmp year

hour:
mov dl,58

year:
call show_how ;将ascii放入显存中
add di,6
loop show

mov ax,4c00h
int 21h

show_what:
push ax
push cx
push si
out 70h,al
in al,71h ;从cmos ram读出对应时间数据

mov ah,al
mov cl,4
shr ah,cl
and al,00001111b

add ah,30h
add al,30h
mov si,offset return
mov ds:[si],ax

pop si
pop cx
pop ax
ret

show_how:
push ax
push bx
push cx
push dx
push si
push di

mov bx,0b800h
mov es,bx
mov si,offset return

mov ax,ds:[si]

mov es:[160*24+di],ah
mov ah,2
mov es:[160*24+di+1],ah

mov es:[160*24+di+2],al
mov es:[160*24+di+3],ah

mov es:[160*24+di+4],dl
mov es:[160*24+di+5],ah

pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret

code ends
end start






