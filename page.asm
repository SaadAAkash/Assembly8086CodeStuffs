            .model small
.stack 100h

.data
a dw 6
b dw 53
u dw 32
v dw 90
pos dw 1
prev dw 0
pos2 dw 150
prev2 dw 29
p1 dw ?
p2 dw ?
q1 dw ?
q2 dw ?
rett dw 0
STRING  DB  'Press Any Key$'

printMenu macro c1,c2,r1,r2
local Line,loop1
mov dx ,r1

loop1:
	mov cx,c1 ; row 

	Line:
	int 10h
	inc cx

	cmp cx,c2
	jl Line

inc dx
cmp dx,r2
jl loop1


endm



pushAll macro 

pushf
push ax
push bx
push cx
push dx

endm

;####################################################


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Pop flag state ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

popAll macro

pop dx
pop cx
pop bx
pop ax
popf

endm


.code 
    mov ax , @data 
    mov ds,ax


main  proc

     
mov ah,0
mov al,13h  
int 10h 


     
     
     mov ah,02h
     mov bh,0
     mov dh,20 ;2nd string er jnno row, value change kore kore dekhlei bujhbi
     mov dl,15;2nd string er jnno col, value change kore kore dekhlei bujhbi
     mov bl,30 ; ei part ta blue
     mov cx,10 ; color text print korar jnno
     int 10h  
     
     
      
     MOV AH, 9  
     LEA DX, STRING 
     INT 21H



;call printCar   	
h:


call printMenuCar
mov ax, pos
mov prev, ax
inc ax

mov pos,ax

cmp ax,300
jle k
mov pos,0
;;;;;;;;;;;;;;;;;;;jmp h

k:
mov ax, pos
mov bx, prev

mov cx, pos2
mov dx,prev2

mov pos,cx
mov prev,dx

call printMenuCar

mov prev2,cx
inc cx
mov pos,ax
mov prev,bx
call printStars
call printCar
mov pos2,cx
cmp cx,300
jle h
mov pos2,0
jmp h





main endp


printMenuCar proc 
pushAll
	
	mov ax,prev
	add ax,34
	mov a, ax
	mov u, 90
	add ax,15
	mov b,ax
	mov v ,98

	mov ah,0ch
	mov al,0
	mov bh,0
	print a,b,u,v
	
	mov ax,prev
	mov a, ax
	
	add ax,47
	mov b,ax
	mov v ,90
	mov u, 32

	mov ah,0ch
	mov al,0
	mov bh,0

	print a,b,u,v
	
	mov ax,prev
	add ax,22
	mov a, ax
	mov u, 61
	add ax,11
	mov b,ax
	mov v ,152

	mov ah,0ch
	mov al,0
	mov bh,0
	print a,b,u,v	
;//////////////////////////////////////////////////////////////////
	mov ax,pos
	mov a, ax
	mov u, 32
	add ax,47
	mov b,ax
	mov v ,90

	mov ah,0ch
	mov al,190
	mov bh,0
	
	
	print a,b,u,v

	mov ax,pos
	add ax,34
	mov a, ax
	mov u, 90
	add ax,15
	mov b,ax
	mov v ,98

	mov ah,0ch
	mov al,190
	mov bh,0
	print a,b,u,v

	mov ax,pos
	add ax,22
	mov a, ax
	mov u, 61
	add ax,11
	mov b,ax
	mov v ,152

	mov ah,0ch
	mov al,98
	mov bh,0
	print a,b,u,v
	print 0,320,150,152
	MOV     CX, 0FH
	MOV     DX, 4240H
	MOV     AH, 70H
	INT     15H



popAll
ret
printMenuCar endp

printStars proc
pushAll
	mov ah,0ch
	mov al,25
	mov bh,0
	print 0,1,0,1
	print 10,11,20,21
	print 20,21,5,6
	print 31,33,11,12
	print 50,51,40,41
	print 60,61,30,32
	print 180,182,5,6
	print 131,133,21,22

	print 110,111,30,31
	print 150,151,20,21
	print 220,221,25,26
	print 231,232,11,12
	print 250,251,30,31
	print 260,261,20,22
	print 280,282,5,7
	print 315,316,21,22

	print 310,311,30,31
	print 250,251,20,21
	print 120,121,25,26
	print 291,292,11,12
	print 280,281,30,31
	print 150,151,20,22
	print 190,192,5,7
	print 215,216,21,22
	
popAll
ret
printStars endp

printCar proc
	pushAll
	mov ax,pos
	mov ah,0ch
	
	mov bh,0
	print 18,24,170,190
	print 18,36,170,176
	print 18,36,184,190 ; c is done

	print 42,48,170,190
	print 42,60,184,190 ; l is done

	print 66,72,170,190
	print 78,84,170,190
	print 72,78,170,176
	print 72,78,180,186 ; A is done

	print 90,108,186,190
	print 90,108,178,182
	print 90,108,170,174
	print 90,96,170,178
	print 102,108,182,190 ; S is done

	print 114,120,170,190
	print 126,132,170,190
	print 120,126,180,186 ; H is done

	
	print 154,160,170,190
	print 166,172,170,190
	print 160,166,170,176
	print 160,166,184,190 ; o is done

	print 178,184,170,190
	print 184,196,170,176
	print 184,191,180,186 ; F is done

	print 218,224,170,190
	print 218,236,170,176
	print 218,236,184,190 ; c is done

	print 242,248,170,190
	print 254,260,170,190
	print 248,254,170,176
	print 248,254,180,186 ;A is done

	print 266,270,170,190 
	print 266,284,170,174
	print 266,284,178,182
	print 276,282,182,190
	print 280,284,170,182 ;R is done

	print 290,308,186,190
	print 290,308,178,182
	print 290,308,170,174
	print 290,296,170,178
	print 302,308,182,190 ; S is done

	popAll
ret
printCar endp



end   