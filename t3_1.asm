;实验3.2
;计算1到100的奇数之和

assume cs:code
code segment
start:
mov ax,1
mov bx,1
mov cx,49

s:
add bx,2
add ax,bx
loop s

mov ax,4c00h
int 21h

code ends
end start