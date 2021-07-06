;练习17.2
;字符串的输入和删除
;程序处理过程：
;（1）	调用int 16h读取键盘输入
;（2）	如果是字符，进入字符栈，显示字符栈中的所有字符；继续执行（1）
;（3）	如果是退格键，从字符栈中弹出一个字符，显示字符栈中的所有字符；继续执行（1）
;（4）	如果是enter键，向字符栈中压入0，返回
assume cs:code
code segment
start:

call getstr

return:
mov ax,4c00h
int 21h

getstr:
push ax

getstrs:
mov ah,0
int 16h

cmp al,20h ;ascii码小于20h，说明不是字符
jb nochar ;低于则转移
mov ah,0
call charstack ;字符入栈
mov ah,2
call charstack ;显示栈中的字符
jmp getstrs

nochar:
cmp ah,0eh ;退格键的扫描码
je backspace
cmp ah,1ch ;回车键的扫描码
je enter
jmp getstrs

backspace:
mov ah,1
call charstack ;字符出栈
mov ah,2
call charstack
jmp getstrs

enter:
mov al,0
mov ah,0
call charstack ;0入栈
mov ah,2
call charstack

pop ax
ret

;子程序：字符栈的入栈、出栈和显示的参数说明：
;-	（ah）：功能号，0表示入栈，1表示出栈，2表示显示
;-	ds：si指向字符栈空间
;-	0号功能：（al）表示入栈字符
;-	1号功能：（al）表示返回的字符
;-	2号功能：（dh）、·（dl）表示字符串在屏幕中显示的行和列
charstack:
jmp short charstart

table dw charpush,charpop,charshow
top dw 0 ;栈顶

charstart:
push ax
push bx
push cx
push dx
push es
push si
push di

cmp ah,2
ja sret
mov bl,ah
mov bh,0
add bx,bx
jmp word ptr table[bx]

charpush:
mov bx,top
mov [si][bx],al ;ds：si指向字符栈空间,bx表示偏移
inc top
jmp sret

charpop:
cmp top,0
je sret
dec top
mov bx,top
mov al,[si][bx]
jmp sret

charshow:
mov bx,0b800h
mov es,bx
mov al, 160
mov ah,0
mul dh
mov di, ax
add dl, dl
mov dh,0
add di, dx

mov bx,0

charshows:
cmp bx,top
jne noempty
mov byte ptr es:[di],' '
jmp sret

noempty:
mov al,[si][bx]
mov es:[di],al
mov byte ptr es:[di+2],' '
inc bx
add di,2
jmp charshows

sret:
pop di
pop si
pop es
pop dx
pop cx
pop bx
pop ax
ret

code ends
end start
