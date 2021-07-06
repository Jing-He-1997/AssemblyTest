;实验16
; 安装一个新的int 7ch中断例程，为显示输出提供如下功能子程序：
;(1) 清屏。
;(2) 设置前景色。
;(3) 设置背景色。
;(4) 向上滚动一行。
;入口参数说明：
;(1) 用 ah 寄存器传递功能号：0 表示清屏，1表示设置前景色，2 表示设置背景色，3 表示向上滚动一行；
;(2) 对于2、3号功能，用 al 传送颜色值，(al) ∈{0,1,2,3,4,5,6,7}

assume cs:code

code segment
start:

mov ax,cs
mov ds,ax
mov si,offset int7ch

mov ax,0
mov es,ax
mov di,204h

mov cx,offset int7chends - offset int7ch
cld
rep movsb

mov ax,0
mov es,ax

push es:[7ch*4]
pop es:[200h]
push es:[7ch*4+2]
pop es:[202h]

cli
mov word ptr es:[7ch*4],204h
mov word ptr es:[7ch*4+2],0
sti

mov ax,4c00h
int 21h

;通知编译器从204H开始重新计算标号
;org是汇编器的伪指令，是告诉编译器下一条汇编语句的偏移地址
org 204h


int7ch:
jmp short set

table dw fun1,fun2,fun3,fun4

set:
push ax
push bx
cmp ah,3
ja sret

mov bl,ah
mov bh,0
add bx,bx
call word ptr table[bx]

sret:
pop bx
pop ax
iret

fun1:
push bx
push cx
push es

mov bx,0b800h
mov es,bx
mov bx,0
mov cx,2000

s0:
mov byte ptr es:[bx],''
add bx,2
loop s0

pop es
pop cx
pop bx
ret

fun2:
push bx
push cx
push es

mov bx,0b800h
mov es,bx
mov bx,1
mov cx,2000

s1:
and byte ptr es:[bx],11111000b
or es:[bx],al
add bx,2
loop s1

pop es
pop cx
pop bx
ret

fun3:
push bx
push cx
push es

mov bx,0b800h
mov es,bx
mov bx,1
mov cx,2000

s2:
and byte ptr es:[bx],10001111b
or es:[bx],al
add bx,2
loop s2

pop es
pop cx
pop bx
ret

fun4:
push ax
push bx
push cx
push es
push si

mov bx,0b800h
mov es,bx
mov ds,bx
mov si,160
mov di,0
cld
mov cx,24

copy:
push cx
mov cx,160
;movsb指令用于把字节从ds:si 搬到es:di；
;rep是repeat的意思
;rep movsb 就是多次搬运。
;搬运前先把字符串的长度存在cx寄存器中
;然后重复的次数就是cx寄存器所存数据的值。
rep movsb
pop cx
loop copy

mov cx,80
mov bx,0
s4:
mov byte ptr es:[160*24+bx],''
add bx,2
loop s4

pop si
pop es
pop cx
pop bx
pop ax
ret

int7chends:
nop

code ends
end start


;注意
;table是什么？它是个标号，在编译器层面，它就是一个偏移地址。这个偏移地址怎么来的？是在编译时编译器计算出来的。
;在这个例子中，装载到内存0:200H开始处，它应该代表了cs:[206H](我们所期望的)，但是此时table由于装载程序编译的原因，table的偏移地址发生了改变。它不代表了cs:[206H]了。
;为什么在装载程序中，offset int7ch这种标号没有问题？它们在安装程序中只起到了机器码定位的作用。在安装程序中此标号的指令CPU是不执行的。
;在装载程序编译时，已经将table翻译成地址0043H的，那么其他的标号呢？一样，都不对了。





