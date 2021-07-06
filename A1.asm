;课程设计1
;在屏幕中显示数据，且要为十进制数据
;编写三个子程序来解决三个主要问题：
;解决在屏幕中如何显示内容的问题
;解决如何将内存中的二进制数转换成十进制的ASCII码值的问题
;解决除法的溢出问题

assume cs:code 

data segment  
	;  bx= 0
	db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
	db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
	db '1993','1994','1995'
	;以上是表示21年的21个字符串
	
	;bx+84
	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
	dd 245980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
	;以上是表示21年公司总收入的21个dword型数据
	
	
	; bp = 168
	dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
	dw 11542,14430,15257,17800
	;以上是表示21年公司雇员人数的21个word型数据
data ends

table segment
db 21 dup ('year    x          y        z  ',0)
table ends

stack segment
db 64 dup (0)
stack ends

code segment
start:

mov ax,data
mov es,ax
mov bx,0

mov ax,table
mov ds,ax
mov si,0

mov ax,stack
mov ss,ax
mov sp,32

mov di,0
mov bp,0

mov cx,21

show_string:
push cx

mov ax,es:[bx]
mov ds:[si],ax
mov ax,es:2[bx]
mov ds:2[si],ax ;复制年份

mov ax,es:84[bx]
mov dx,es:86[bx]
push si
add si,8
call dtoc
pop si ;将总收入转换为字符并复制

mov ax,es:168[bp]
mov dx,0
push si
add si,19
call dtoc
pop si ;将雇员数转换为字符并复制


mov ax,es:84[bx]
mov dx,es:86[bx]
div word ptr es:168[bp] ;平均收入

mov dx,0
push si
add si,28
call dtoc
pop si ;将平均收入转换为字符并复制
pop es

add si,32
add bp,2
add bx,4
pop cx
loop show_string


mov cx,21
mov si,0
mov dh,4
s1:
push cx
mov dl,0
mov cl,71h
call show_str
inc dh
add si,32
pop cx
loop s1

mov ax,4c00h
int 21h

dtoc:
push di

dtoc_string:
mov cx,10
call divdw
add cx,30h
push cx
inc di

mov cx,0
or cx,ax
or cx,dx
jcxz dtoc_copy
jmp short dtoc_string

dtoc_copy:
mov cx,di

copy:
pop ax
mov ds:[si],al
inc si
loop copy

pop di
ret

divdw:
push bx
push ax

mov ax,dx
mov dx,0
div cx

mov bx,ax
pop ax

div cx

mov cx,dx
mov dx,bx

pop bx
ret

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
mov al,dl
add al,al
add bx,ax ;总偏移量


mov al,cl
mov di,0

s:
mov cl,ds:[si]
mov ch,0
jcxz rset
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

