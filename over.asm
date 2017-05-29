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

print macro c1,c2,r1,r2
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


call gameOver
call printStars
call printCar
inc pos
jmp h





main endp

gameOver proc
pushAll

	mov ah,0ch
	mov al,50
	mov bh,0
print 60,66,100,120
print 60,78,100,106
print 60,78,114,120
print 72,78,110,114 ;G is done

print 84,102,100,106
print 84,90,100,120
print 96,102,100,120
print 90,96,110,116 ; A is done

print 108,126,100,106
print 108,114,100,120
print 120,126,100,120
print 116,118,100,116 ; M is done

print 132,150,100,106
print 132,138,100,120
print 132,150,114,120
print 132,144,109,112 ; E is done


print 170,188,100,106
print 170,176,100,120
print 170,188,114,120
print 182,188,100,120; O is done

print 194,200,100,114
print 198,208,114,120
print 206,212,100,114 ; V

print 218,236,100,106
print 218,224,100,120
print 218,224,114,120
print 218,230,109,112
print 218,236,114,120 ;E is done

print 242,260,100,104
print 242,246,100,120
print 242,260,109,112
print 256,260,104,109

print 252,258,112,120

popAll
ret
gameOver endp

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


printCar proc  ;; ekhn naam hoise car8 e printMenuCar2
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
