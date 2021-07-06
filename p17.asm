;练习17
;编程，接收用户键盘输入
;输入r，屏幕上的字符设为红色
;输入g，屏幕上的字符设为绿色
;输入b，屏幕上的字符设为蓝色

assume cs:code
code segment
start:

mov ah,0
int 16h

mov ah,1

cmp al,'r'
je red

cmp al,'g'
je green

cmp al,'b'
je blue

jmp short sret

red:
shl ah,1

green:
shl ah,1

blue:
mov bx,0b800h
mov es,bx
mov si,1
mov cx,2000

s:
and byte ptr es:[si],11111000b
or es:[si],ah
add si,2
loop s

sret:
mov ax,4c00h
int 21h

code ends
end start



