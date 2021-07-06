;实验10.2
;解决除法溢出的问题
;名称：divdw
;功能：进行不会产生溢出的除法运算，被除数为 dword 型，除数为 word 型，结果为 dword 型
;参数：（ax）= dword 型数据的低 16 位；（dx）= dword 型数据的低 16 位；（cx）= 除数
;返回：（dx）= 结果的高 16 位；（ax）= 结果的低 16 位；（cx）= 余数
;应用举例：计算 1000000 / 10

assume cs:code

code segment
start:

mov ax,4240h
mov dx,0fh
mov cx,0ah

call divdw

mov ax,4c00h
int 21h

divdw:
push ax

mov ax,dx
mov dx,0
div cx

mov bx,ax

pop ax
div cx

mov cx,dx
mov dx,bx

ret

code ends
end start
