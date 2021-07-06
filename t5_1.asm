;实验5.2
;将下面的程序编译、连接，用debug加载、跟踪，然后回答问题

assume cs:code,ds:data,ss:stack

code segment
start:
mov ax,stack
         mov ss,ax
         mov sp,16
         mov ax,data
         mov ds,ax
         push ds:[0]
         push ds:[2]
         pop ds:[2]
         pop ds:[0]
         mov ax,4c00h
         int 21h
code ends
data segment
         dw 0123h,0456h
data ends
stack segment
         dw 0,0
stack ends
end start
