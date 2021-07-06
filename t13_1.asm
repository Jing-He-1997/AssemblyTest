;实验13.2
;编写并安装int 7ch中断例程，功能为完成loop指令的功能。
;参数:（cx）=循环次数，（bx）=位移。
;以上中断例程安装好后，对下面的程序进行单步跟踪，尤其注意int，iret指令执行前后cs，ip的和栈中的状态。
;在屏幕中间显示80个 ‘！’。
assume cs:code 
code segment
start:

mov ax,cs
mov ds,ax
mov si,offset int7ch

mov ax,0
mov es,ax
mov di,200h

mov cx,offset int7chends - offset int7ch
cld
rep movsb

mov ax,0
mov es,ax
mov word ptr es:[7ch*4],200h
mov word ptr es:[7ch*4+2],0

mov ax,4c00h
int 21h

int7ch:
dec cx
jcxz int7ch_over
push bp ;现在栈顶指向bp
mov bp,sp ;定位到栈
add ss:[bp+2],bx ;低位到高位 指向ip
pop bp  ;现在栈顶指向ip

int7ch_over:
iret

int7chends:
nop

code ends
end start