;实验3
;将程序保存为asm文件，并且生成可执行文件exe

assume cs:code
code segment
start:
mov ax,2000h
mov ss,ax
mov sp,0
add sp,10
pop ax
pop bx
push ax
push bx
pop ax
pop bx

mov ax,4c00h
int 21h

code ends
end start