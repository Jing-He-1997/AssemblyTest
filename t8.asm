;实验8
;程序能否正常运行

assume cs:code
code segment

mov ax,4c00h
int 21h

start:
mov ax,0

s:
nop
nop

mov di,offset s
mov si,offset s2
mov ax,cs:[si]
mov cs:[di],ax

s0:
jmp short s

s1:
mov ax,0
int 21h
mov ax,0

s2:
jmp short s1 ;相对位移：向上偏移8个字节
nop

code ends
end start