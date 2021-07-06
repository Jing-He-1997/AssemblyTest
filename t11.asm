;实验11
;把字符串中的小写字母转化为大写字母

assume cs:code

data segment
db "Beginner's All-purpose Symbolic Instruction Code.",0
data ends

code segment
start:
mov ax,data
mov ds,ax
mov si,0

mov ax,0b800h
mov es,ax
mov di,0

mov al,3
s:
mov cl,[si]
mov ch,0
jcxz next
mov es:[di],cl
mov es:[di+1],al
inc si
add di,2
jmp short s


next:
mov si,0
mov di,0
call letter_change

mov al,3
s3:
mov cl,[si]
mov ch,0
jcxz over
mov es:160[di],cl
mov es:160[di+1],al
inc si
add di,2
jmp short s3

over:
mov ax,4c00h
int 21h

letter_change:
push si

s0:
mov cl,ds:[si]
mov ch,0
jcxz s2
cmp cl,61h
jb s1
cmp cl,7ah
ja s1

sub cl,20h
mov ds:[si],cl

s1:
inc si
jmp short s0

s2:
pop si
ret

code ends
end start
