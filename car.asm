.model small
.stack 100h

.data
   x1 dw 0
   x2 dw 20
   y1 dw 0
   y2 dw 20
  
printcar macro a,b,c,d
local box,L1
mov dx,a ; row 


box:
mov cx,c ;column

L1:
int 10h
inc cx
cmp cx,d
jl L1

inc dx
inc bh
cmp dx,b

jl box	

endm

printline macro a
local Line
mov dx ,a 
mov cx,0 ; row 

Line:
int 10h
inc cx
cmp cx,320
jl Line

endm

printbar macro aa
local Line2
mov cx ,aa 
mov dx,0 ; row 

Line2:
int 10h
inc dx
cmp dx,180
jl Line2

endm


.code 
    
    mov ax , @data
    mov ds,ax

main  proc
      
mov ah,0
mov al,13h
int 10h

mov ah,0ch
mov al,128
mov bh,0

printbar 0
printbar 80
printbar 160
printbar 240
;printbar 320


printline 0
printcar 0,20,0,20 ;call print
printcar 20,40,20,40
printcar 40,60,0,20
printcar 0,20,40,60 ;call print
printcar 20,40,60,80
printcar 40,60,40,60


printline 60
printcar 60,80,0,20 ;call print
printcar 80,100,20,40
printcar 100,120,0,20
printcar 60,80,40,60 ;call print
printcar 80,100,60,80
printcar 100,120,40,60
printline 120
printcar 120,140,0,20 ;call print
printcar 140,160,20,40
printcar 160,180,0,20
printcar 120,140,40,60 ;call print
printcar 140,160,60,80
printcar 160,180,40,60
printline 180
     


main  endp
end   main