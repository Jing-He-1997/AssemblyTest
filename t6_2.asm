;实验6.3
;将data段中的每个单词的前4个字母改为大写字母

assume cs:code
data segment
db '1. display      '
db '2. brows        '
db '3. replace      '
db '4. modify       '
data ends

code segment
start:
mov ax,data
mov ds,ax
mov bx,0

mov cx,4

s0:
push cx
mov si,3
mov cx,4

s1:
and byte ptr ds:[bx+si],11011111b
inc si
loop s1

pop cx
add bx,16
loop s0

mov ax,4c00h
int 21h

code ends
end start

