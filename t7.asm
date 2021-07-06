;实验7
;将 data 段中的数据按如下格式写入到 table 段中，并计算 21 年中的人均收入（取整），结果也按照下面的格式保存在 table 段中。

assume cs:code

data segment
  db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
  db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
  db '1993','1994','1995'
  ;以上表示21年的21个字符串

  dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
  dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
  ;以上表示21年公司总收入的21个dword型数据

  dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
  dw 11542,14430,15257,17800
  ;以上表示21年公司雇员人数的21个word型数据
data ends

table segment
db 21 dup ('year summ ne ?? ')
table ends

code segment
start:
mov ax,data
mov ds,ax

mov ax,table
mov es,ax
mov si,0
mov bx,0
mov di,0

mov cx,21

s:
push ax
push cx


mov ax,ds:[bx]
mov es:[si],ax
mov ax,ds:2[bx]
mov es:2[si],ax ;复制年份

mov ax,ds:84[bx]
mov es:5[si],ax
mov dx,ds:86[bx]
mov es:7[si],dx ; 复制公司总收入

mov cx,ds:168[di]
mov es:0ah[si],cx ;复制雇员数

call divdw
mov es:0dh[si],ax ;计算出人均收入并复制

add bx,4
add di,2
add si,16

pop cx
pop ax
loop s

mov ax,4c00h
int 21h

divdw:
push bx
push cx
push dx
push ax ;保护数据


mov ax,dx
mov dx,0
div cx 
mov bx,ax ;int(H/N)    高16位

pop ax
div cx ;[rem(H/N)*65536+L]/N  低16位和余数

mov cx,dx
mov dx,bx

pop dx
pop cx
pop bx

ret

code ends
end start






