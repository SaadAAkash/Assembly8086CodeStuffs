.model small
.stack 100h

.data
   total dw 5 dup(0)
   countdigit dw 0
   playerpos dw 1

   enemyrow1pos dw 1 ; inc hwe 2 hbe game er start e
   enemyrow2pos dw -1 ; inc hwe 0 hbe
   enemyrow3pos dw -3; inc hwe -1 hbe
 
   point dw 0
   score db "SCORE:$"
   msg db 'Press a->up, s->down$'

  ;;;;;;;;;;;;MENU PRINT VARS;;;;;;;;;;
   
    menua dw 6
    menub dw 53
    menuu dw 32
    menuv dw 90
    menupos dw 1
    menuprev dw 0
    menupos2 dw 150
    menuprev2 dw 29
    menup1 dw ?
    menup2 dw ?
    menuq1 dw ?
    menuq2 dw ?
    rett dw 0
    STRING  DB  'Press Any Key$'

print macro c1,c2,r1,r2   ;;;MENUR JONNE::::::::
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;fnameb db 'car',0

;car db 4,4,4,4,4,0,0,0,0,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,4,4,4,4
;db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0eh,0eh
;db 4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,4,4,4,4,0,0,4,4,4,0eh,0eh,0eh
;db 4,4,4,0,4,4,4,0,0,0,0,0,0,0,0,4,4,4,0,0,0,0,4,4,4,0eh,0eh,0eh
;db 4,4,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,4,4,4,4,4
;db 4,4,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,4,4,4,4,4
;db 4,4,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,4,4,4,4,4
;db 4,4,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,4,4,4,4,4
;db 4,4,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,4,4,4,4,4
;db 4,4,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,4,4,4,4,4
;db 4,4,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,4,4,4,4,4
;db 4,4,4,0,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,4,4,4,4,4,4
;db 4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,4,4,4,4,4,4,4,4,4,4,4,0eh,0eh
;db 4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,4,4,4,0eh,0eh,0eh
;db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0eh,0eh,0eh
;db 4,4,4,4,4,0,0,0,0,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,4,4,4,4


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this macro is for player car printing ;;;;;;;;;;;;;;;
 
printcar macro a,b,c,d  ; row a thke b porjonto & col c thke d porjonto print hbe 
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this macro is for horizontal grids ;;;;;;;;;;;;;;;;;;

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

;#####################################################


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This macro is for vertical grids ;;;;;;;;;;;;;;;;;;;

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
;####################################################

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; push flag state  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pushFlag macro 

pushf
push ax
push bx
push cx
push dx

endm

;####################################################


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Pop flag state ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

popFlag macro

pop dx
pop cx
pop bx
pop ax
popf

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

; code segment starts here ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.code 
    
    mov ax , @data ; data segment initialized
    mov ds,ax

;;;;;; Main Procedure ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main  proc

     
mov ah,0
mov al,13h   ;;;;;;;;;;;;;;;;;;;;;; 13 means 320 * 200 pixels
int 10h

;;;;;;;;;;;;;;;;;MENU PRINT;;;;;;;;;;;;;;;;;;;;;


MENUPRINTING:

;;;;;;;update all values for the new game! ;;;;;;;;;;;;;;;;

mov playerpos,1
mov enemyrow1pos,1
mov enemyrow2pos,-1
mov enemyrow3pos,-3


mov point,0

;;;;;;;;;;;;;;;;;;;black out;;;;;;;;;;;;;;;;;

mov ah,0ch
mov al,0         
mov bh,0
printcar 0,200,0,320

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

mov ah,01h
int 16h
jz h ; if key na dey
jmp MENUBLACKOUT    

h:

mov ah,01h
int 16h
jz l1
jmp MENUBLACKOUT

l1:
call printMenuCar ; car draw korbe
mov ax, menupos
mov menuprev, ax
inc ax

mov menupos,ax

cmp ax,300
jle k
mov menupos,0

k:

mov ax, menupos
mov bx, menuprev

mov cx, menupos2
mov dx, menuprev2

mov menupos,cx
mov menuprev,dx

call printMenuCar

mov menuprev2,cx
inc cx
mov menupos,ax
mov menuprev,bx
call printStars
call printMenuCar2
mov menupos2,cx
cmp cx,300
jle h
mov menupos2,0


MENUBLACKOUT:

;;;;;;;;;;;;;;;;;;;;;;REMOVING PREV MENU BLACK OUT!;;;;;;;;;;;;;;;;;
mov ah,0ch
mov al,0         
mov bh,0
printcar 0,200,0,320


;;;;;;;;;;;;score printing;;;;;;;;;;;;;;;;;
;;;;;;score niche newa;;;;;;;;;;;

SCOREPRINTING:

;;;;;;;how to play;;;;;;;;;;;;;;;;

mov ah,02h
mov bh,0
mov dh,23 ;2nd string er jnno row, value change kore kore dekhlei bujhbi
mov dl,00;2nd string er jnno col, value change kore kore dekhlei bujhbi
int 10h

mov ah,09h
lea dx, msg
int 21h

 ;;;;;;;score;;;;;;;;;;;;;;;

mov ah,02h
mov bh,0
mov dh,23 ;2nd string er jnno row, value change kore kore dekhlei bujhbi
mov dl,21;2nd string er jnno col, value change kore kore dekhlei bujhbi
int 10h

mov ah,09h
lea dx, score
int 21h


;;;;;;;;;;;;;;;USER LOOP;;;;;;;;;;;;;;;;;;;;;;;;;

userloop:


inc point

pushFlag
call printScore
mov ah,02h
mov bh,0
mov dh,23  ; row
mov dl,30  ; column
int 10h

mov ah,09h
lea dx, total
int 21h 
popFlag




  mov ah, 01h ; checks if a key is pressed
    int 16h
    jz heroposisdone ; zero = no pressed
    
    mov ah, 00h ; get the keystroke
    int 16h

    begin_pressed:
    cmp al, 115
    je y
    cmp al, 97
    je z


  jmp heroposisdone


y:
inc playerpos   ; at 1st,playerpos = 2 

cmp playerpos,4
je makepos1 ; if 4 , playerpos again back to 0 
jmp heroposisdone

z:
dec playerpos   ; at 1st,playerpos = 2 

cmp playerpos,0
je makepos2 ; if 4 , playerpos again back to 0 
jmp heroposisdone


makepos1: 
mov playerpos, 3
jmp heroposisdone

makepos2: 
mov playerpos, 1
jmp heroposisdone

heroposisdone:

pushFlag       ;all value in stack 

call printgraph  ; the grid print

;;;;;;;;;this steadies the print;;;;;;;;;;;;
MOV     CX, 0FH
MOV     DX, 4240H
MOV     AH, 70H
INT     15H
popFlag
pushFlag

cmp playerpos , 1
je pos1
cmp playerpos , 2
je pos2
cmp playerpos , 3
je pos3

jmp userloop

pos1:
call player_pos_1
popFlag
jmp enemyloop
;jmp userloop


pos2:
call player_pos_2
popFlag
jmp enemyloop
; userloop

pos3:
call player_pos_3
popFlag
jmp enemyloop


;;;;;;;;;;;;;;;;;;;;;ENEMY LOOP;;;;;;;;;;;;;;;;;;

enemyloop:

pushFlag
cmp enemyrow2pos,4
je check1
jmp inner1

check1:
cmp playerpos,2
je GAMEOVERLOOP

inner1:
cmp enemyrow1pos,4
je check2
jmp inner2

check2:
cmp playerpos,1
je GAMEOVERLOOP


inner2:

cmp enemyrow3pos,4
je check3
jmp inner3

check3:
cmp playerpos,3
je GAMEOVERLOOP

inner3:

popFlag
pushFlag
inc enemyrow1pos   
inc enemyrow2pos
inc enemyrow3pos

call printgraph

MOV     CX, 0FH
MOV     DX, 4240H
MOV     AH, 86H
INT     15H
popFlag
pushFlag

jmp a1

a1:
cmp enemyrow1pos,5
je changeValueRow1 ; every time returns to enemyloop
jmp b1

b1:
cmp enemyrow2pos,5
je changeValueRow2 ; every time returns to enemyloop
jmp c1

c1:
cmp enemyrow3pos,5
je changeValueRow3 ; every time returns to enemyloop 
jmp d1


changeValueRow1:

mov enemyrow1pos, 0
pushFlag       ;all value in stack 
call printgraph  ; the grid print
jmp b1


changeValueRow2:

mov enemyrow2pos, 0
pushFlag       ;all value in stack 
call printgraph  ; the grid print
jmp c1

changeValueRow3:

mov enemyrow3pos, 0
pushFlag       ;all value in stack 
call printgraph  ; the grid print
jmp d1

d1:
cmp enemyrow1pos , 1
je eposrow1pos1
cmp enemyrow1pos , 2
je eposrow1pos2
cmp enemyrow1pos , 3
je eposrow1pos3
cmp enemyrow1pos , 4
je eposrow1pos4
jmp e1

e1:
cmp enemyrow2pos , 1
jl eposrow2pos1
cmp enemyrow2pos , 2
jl eposrow2pos2
cmp enemyrow2pos , 3
jl eposrow2pos3
cmp enemyrow2pos , 4
jl eposrow2pos4

jmp f1

f1:
cmp enemyrow3pos , 1
jl eposrow3pos1
cmp enemyrow3pos , 2
jl eposrow3pos2
cmp enemyrow3pos , 3
jl eposrow3pos3
cmp enemyrow3pos , 4
jl eposrow3pos4

jmp userloop

;;;;;;;;;;;;;;;ROW 1;;;;;;;;;;;;;;;;;

eposrow1pos1:
call enemy_row1pos1
popFlag

call printgraph

MOV     CX, 0FH
MOV     DX, 4240H
MOV     AH, 70H
INT     15H
popFlag
pushFlag

jmp e1

eposrow1pos2:
call enemy_row1pos2
popFlag

call printgraph

MOV     CX, 0FH
MOV     DX, 4240H
MOV     AH, 70H
INT     15H
popFlag
pushFlag

jmp e1

eposrow1pos3:
call enemy_row1pos3
popFlag

call printgraph

MOV     CX, 0FH
MOV     DX, 4240H
MOV     AH, 70H
INT     15H
popFlag
pushFlag

jmp e1

eposrow1pos4:
call enemy_row1pos4
popFlag

call printgraph

MOV     CX, 0FH
MOV     DX, 4240H
MOV     AH, 70H
INT     15H
popFlag
pushFlag

jmp e1

;;;;;;;;;;;;;;ROW2;;;;;;;;;;;;;;;;;;
eposrow2pos1:
call enemy_row2pos1
popFlag

call printgraph

MOV     CX, 0FH
MOV     DX, 4240H
MOV     AH, 70H
INT     15H
popFlag
pushFlag

jmp f1


eposrow2pos2:
call enemy_row2pos2
popFlag

call printgraph

MOV     CX, 0FH
MOV     DX, 4240H
MOV     AH, 70H
INT     15H
popFlag
pushFlag

jmp f1

eposrow2pos3:
call enemy_row2pos3
popFlag

call printgraph

MOV     CX, 0FH
MOV     DX, 4240H
MOV     AH, 70H
INT     15H
popFlag
pushFlag

jmp f1


eposrow2pos4:
call enemy_row2pos4
popFlag

call printgraph

MOV     CX, 0FH
MOV     DX, 4240H
MOV     AH, 70H
INT     15H
popFlag
pushFlag

jmp f1

;;;;;;;;;;;;;;ROW3;;;;;;;;;;;;;;;;;;

eposrow3pos1:
call enemy_row3pos1
popFlag

call printgraph

MOV     CX, 0FH
MOV     DX, 4240H
MOV     AH, 70H
INT     15H
popFlag
pushFlag

jmp userloop

eposrow3pos2:
call enemy_row3pos2
popFlag

call printgraph

MOV     CX, 0FH
MOV     DX, 4240H
MOV     AH, 70H
INT     15H
popFlag
pushFlag

jmp userloop

eposrow3pos3:
call enemy_row3pos3
popFlag

call printgraph

MOV     CX, 0FH
MOV     DX, 4240H
MOV     AH, 70H
INT     15H
popFlag
pushFlag

jmp userloop

eposrow3pos4:
call enemy_row3pos4
popFlag

call printgraph

MOV     CX, 0FH
MOV     DX, 4240H
MOV     AH, 70H
INT     15H
popFlag
pushFlag

jmp userloop

;;;;;;;;;;;;;;;;;;;;;;;GAME OVER MENU::::::::::::::::;;;;;;;;;;;

GAMEOVERLOOP:

mov ah,0ch
mov al,0         
mov bh,0
printcar 0,200,0,320

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
hOVER:


call gameOver ; print game over
call printStars 
call printMenuCar2  ; write clash of cars

;inc menuPos

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PRESS ANY KEY INPUT hole menu;;;;;;;;;;;;

mov ah,01h
int 16h
;jz hOVER ; if key na dey
;jmp MENUPRINTING

jz MENUPRINTING ; if key na dey
jmp hOVER

main  endp   ;;;;;;;;;;;;;NOTE: eikhane main endp ;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Player position 1 procedure ;;;;;;;;;;;;;;;;;;;;;

player_pos_1 proc

mov ah,0ch
mov al,0  ;;;; removing previous positions
mov bh,0

printcar 60,80,0,20 ;call print
printcar 80,100,20,40
printcar 100,120,0,20
printcar 60,80,40,60 ;call print
printcar 80,100,60,80
printcar 100,120,40,60

printcar 120,140,0,20 ;call print
printcar 140,160,20,40
printcar 160,180,0,20
printcar 120,140,40,60 ;call print
printcar 140,160,60,80
printcar 160,180,40,60

mov ah,0ch
mov al,9
mov bh,0

printcar 0,20,0,20 ;call print
printcar 20,40,20,40
printcar 40,60,0,20
printcar 0,20,40,60 ;call print
printcar 20,40,60,80
printcar 40,60,40,60


ret

player_pos_1 endp

;####################################################


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Player position 2 procedure ;;;;;;;;;;;;;;;;;;;;;

player_pos_2 proc

mov ah,0ch
mov al,0         ;;;; removing previous positions
mov bh,0


printcar 0,20,0,20 ;call print
printcar 20,40,20,40
printcar 40,60,0,20
printcar 0,20,40,60 ;call print
printcar 20,40,60,80
printcar 40,60,40,60


printcar 120,140,0,20 ;call print
printcar 140,160,20,40
printcar 160,180,0,20
printcar 120,140,40,60 ;call print
printcar 140,160,60,80
printcar 160,180,40,60

mov ah,0ch
mov al,9
mov bh,0

printcar 60,80,0,20 ;call print
printcar 80,100,20,40
printcar 100,120,0,20
printcar 60,80,40,60 ;call print
printcar 80,100,60,80
printcar 100,120,40,60


ret

player_pos_2 endp

;####################################################


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Player position 2 procedure ;;;;;;;;;;;;;;;;;;;;;

player_pos_3 proc

mov ah,0ch
mov al,0         ;;;; removing previous positions
mov bh,0


printcar 0,20,0,20 ;call print
printcar 20,40,20,40
printcar 40,60,0,20
printcar 0,20,40,60 ;call print
printcar 20,40,60,80
printcar 40,60,40,60

printcar 60,80,0,20 ;call print
printcar 80,100,20,40
printcar 100,120,0,20
printcar 60,80,40,60 ;call print
printcar 80,100,60,80
printcar 100,120,40,60


mov ah,0ch
mov al,9
mov bh,0


printcar 120,140,0,20 ;call print
printcar 140,160,20,40
printcar 160,180,0,20
printcar 120,140,40,60 ;call print
printcar 140,160,60,80
printcar 160,180,40,60


ret

player_pos_3 endp

;####################################################


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;Graph grinting Procedure ;;;;;;;;;;;;;;;;;;;

printGraph proc

mov ah,0ch  ;mode slct
mov al,80  ; colour?
mov bh,0  ; page


printbar 0
printbar 80
printbar 160
printbar 240
printbar 319
printline 0
printline 60
printline 120
printline 180

ret
printgraph endp
;###################################################

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;ENEMY PROCS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

enemy_row1pos1 proc

mov ah,0ch
mov al,0  ;;;; removing previous positions
mov bh,0


printcar 20,40,160,180 ;call print
printcar 20,40,200,220
printcar 0,20,180,200
printcar 0,20,220,240 ;call print
printcar 40,60,180,200
printcar 40,60,220,240 

printcar 20,40,80,100 ;call print
printcar 20,40,120,140
printcar 0,20,100,120
printcar 0,20,140,160 ;call print
printcar 40,60,100,120
printcar 40,60,140,160

printcar 20,40,0,20 ;call print
printcar 20,40,40,60
printcar 0,20,20,40
printcar 0,20,60,80 ;call print
printcar 40,60,20,40
printcar 40,60,60,80 

mov ah,0ch
mov al,36
mov bh,0

printcar 20,40,240,260 ;call print
printcar 20,40,280,300
printcar 0,20,260,280
printcar 0,20,300,320 ;call print
printcar 40,60,260,280
printcar 40,60,300,320 


ret

enemy_row1pos1 endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

enemy_row1pos2 proc

mov ah,0ch
mov al,0  ;;;; removing previous positions
mov bh,0


printcar 20,40,240,260 ;call print
printcar 20,40,280,300
printcar 0,20,260,280
printcar 0,20,300,320 ;call print
printcar 40,60,260,280
printcar 40,60,300,320

printcar 20,40,80,100 ;call print
printcar 20,40,120,140
printcar 0,20,100,120
printcar 0,20,140,160 ;call print
printcar 40,60,100,120
printcar 40,60,140,160

printcar 20,40,0,20 ;call print
printcar 20,40,40,60
printcar 0,20,20,40
printcar 0,20,60,80 ;call print
printcar 40,60,20,40
printcar 40,60,60,80 

mov ah,0ch
mov al,38
mov bh,0

printcar 20,40,160,180 ;call print
printcar 20,40,200,220
printcar 0,20,180,200
printcar 0,20,220,240 ;call print
printcar 40,60,180,200
printcar 40,60,220,240 


ret
enemy_row1pos2 endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;

enemy_row1pos3 proc

mov ah,0ch
mov al,0  ;;;; removing previous positions
mov bh,0


printcar 20,40,240,260 ;call print
printcar 20,40,280,300
printcar 0,20,260,280
printcar 0,20,300,320 ;call print
printcar 40,60,260,280
printcar 40,60,300,320

printcar 20,40,160,180 ;call print
printcar 20,40,200,220
printcar 0,20,180,200
printcar 0,20,220,240 ;call print
printcar 40,60,180,200
printcar 40,60,220,240 

printcar 20,40,0,20 ;call print
printcar 20,40,40,60
printcar 0,20,20,40
printcar 0,20,60,80 ;call print
printcar 40,60,20,40
printcar 40,60,60,80 

mov ah,0ch
mov al,40
mov bh,0

printcar 20,40,80,100 ;call print
printcar 20,40,120,140
printcar 0,20,100,120
printcar 0,20,140,160 ;call print
printcar 40,60,100,120
printcar 40,60,140,160 

ret
enemy_row1pos3 endp

enemy_row1pos4 proc

mov ah,0ch
mov al,0  ;;;; removing previous positions
mov bh,0


printcar 20,40,240,260 ;call print
printcar 20,40,280,300
printcar 0,20,260,280
printcar 0,20,300,320 ;call print
printcar 40,60,260,280
printcar 40,60,300,320

printcar 20,40,160,180 ;call print
printcar 20,40,200,220
printcar 0,20,180,200
printcar 0,20,220,240 ;call print
printcar 40,60,180,200
printcar 40,60,220,240 

printcar 20,40,80,100 ;call print
printcar 20,40,120,140
printcar 0,20,100,120
printcar 0,20,140,160 ;call print
printcar 40,60,100,120
printcar 40,60,140,160 

mov ah,0ch
mov al,40
mov bh,0

printcar 20,40,0,20 ;call print
printcar 20,40,40,60
printcar 0,20,20,40
printcar 0,20,60,80 ;call print
printcar 40,60,20,40
printcar 40,60,60,80 

ret
enemy_row1pos4 endp


;;; enemy position 2 procedure ;;;;;;;;;;;;;;;;;;;;;

enemy_row2pos1 proc

mov ah,0ch
mov al,0         ;;;; removing previous positions
mov bh,0

printcar 80,100,80,100 ;call print
printcar 80,100,120,140
printcar 60,80,100,120
printcar 60,80,140,160 ;call print
printcar 100,120,100,120
printcar 100,120,140,160

printcar 80,100,160,180 ;call print
printcar 80,100,200,220
printcar 60,80,180,200
printcar 60,80,220,240 ;call print
printcar 100,120,180,200
printcar 100,120,220,240

printcar 80,100,0,20 ;call print
printcar 80,100,40,60
printcar 60,80,20,40
printcar 60,80,60,80 ;call print
printcar 100,120,20,40
printcar 100,120,60,80

mov ah,0ch
mov al,36
mov bh,0

printcar 80,100,240,260 ;call print
printcar 80,100,280,300
printcar 60,80,260,280
printcar 60,80,300,320 ;call print
printcar 100,120,260,280
printcar 100,120,300,320 

ret

enemy_row2pos1 endp

enemy_row2pos2 proc

mov ah,0ch
mov al,0         ;;;; removing previous positions
mov bh,0


printcar 80,100,80,100 ;call print
printcar 80,100,120,140
printcar 60,80,100,120
printcar 60,80,140,160 ;call print
printcar 100,120,100,120
printcar 100,120,140,160

printcar 80,100,240,260 ;call print
printcar 80,100,280,300
printcar 60,80,260,280
printcar 60,80,300,320 ;call print
printcar 100,120,260,280
printcar 100,120,300,320 

printcar 80,100,0,20 ;call print
printcar 80,100,40,60
printcar 60,80,20,40
printcar 60,80,60,80 ;call print
printcar 100,120,20,40
printcar 100,120,60,80

mov ah,0ch
mov al,38
mov bh,0

printcar 80,100,160,180 ;call print
printcar 80,100,200,220
printcar 60,80,180,200
printcar 60,80,220,240 ;call print
printcar 100,120,180,200
printcar 100,120,220,240 

ret

enemy_row2pos2 endp

enemy_row2pos3 proc

mov ah,0ch
mov al,0         ;;;; removing previous positions
mov bh,0

printcar 80,100,240,260 ;call print
printcar 80,100,280,300
printcar 60,80,260,280
printcar 60,80,300,320 ;call print
printcar 100,120,260,280
printcar 100,120,300,320 

printcar 80,100,160,180 ;call print
printcar 80,100,200,220
printcar 60,80,180,200
printcar 60,80,220,240 ;call print
printcar 100,120,180,200
printcar 100,120,220,240

printcar 80,100,0,20 ;call print
printcar 80,100,40,60
printcar 60,80,20,40
printcar 60,80,60,80 ;call print
printcar 100,120,20,40
printcar 100,120,60,80

mov ah,0ch
mov al,40
mov bh,0

printcar 80,100,80,100 ;call print
printcar 80,100,120,140
printcar 60,80,100,120
printcar 60,80,140,160 ;call print
printcar 100,120,100,120
printcar 100,120,140,160

ret

enemy_row2pos3 endp


enemy_row2pos4 proc

mov ah,0ch
mov al,0         ;;;; removing previous positions
mov bh,0

printcar 80,100,240,260 ;call print
printcar 80,100,280,300
printcar 60,80,260,280
printcar 60,80,300,320 ;call print
printcar 100,120,260,280
printcar 100,120,300,320 

printcar 80,100,160,180 ;call print
printcar 80,100,200,220
printcar 60,80,180,200
printcar 60,80,220,240 ;call print
printcar 100,120,180,200
printcar 100,120,220,240

printcar 80,100,80,100 ;call print
printcar 80,100,120,140
printcar 60,80,100,120
printcar 60,80,140,160 ;call print
printcar 100,120,100,120
printcar 100,120,140,160

mov ah,0ch
mov al,40
mov bh,0

printcar 80,100,0,20 ;call print
printcar 80,100,40,60
printcar 60,80,20,40
printcar 60,80,60,80 ;call print
printcar 100,120,20,40
printcar 100,120,60,80

ret

enemy_row2pos4 endp

;;; enemy position 3 procedure ;;;;;;;;;;;;;;;;;;;;;

enemy_row3pos1 proc

mov ah,0ch
mov al,0         ;;;; removing previous positions
mov bh,0

printcar 140,160,80,100 ;call print
printcar 140,160,120,140
printcar 120,140,100,120
printcar 120,140,140,160 ;call print
printcar 160,180,100,120
printcar 160,180,140,160 

printcar 140,160,160,180 ;call print
printcar 140,160,200,220
printcar 120,140,180,200
printcar 120,140,220,240 ;call print
printcar 160,180,180,200
printcar 160,180,220,240 

printcar 140,160,0,20 ;call print
printcar 140,160,40,60
printcar 120,140,20,40
printcar 120,140,60,80 ;call print
printcar 160,180,20,40
printcar 160,180,60,80

mov ah,0ch
mov al,36
mov bh,0


printcar 140,160,240,260 ;call print
printcar 140,160,280,300
printcar 120,140,260,280
printcar 120,140,300,320 ;call print
printcar 160,180,260,280
printcar 160,180,300,320 


ret


enemy_row3pos1 endp

enemy_row3pos2 proc

mov ah,0ch
mov al,0         ;;;; removing previous positions
mov bh,0

printcar 140,160,80,100 ;call print
printcar 140,160,120,140
printcar 120,140,100,120
printcar 120,140,140,160 ;call print
printcar 160,180,100,120
printcar 160,180,140,160 

printcar 140,160,240,260 ;call print
printcar 140,160,280,300
printcar 120,140,260,280
printcar 120,140,300,320 ;call print
printcar 160,180,260,280
printcar 160,180,300,320 

printcar 140,160,0,20 ;call print
printcar 140,160,40,60
printcar 120,140,20,40
printcar 120,140,60,80 ;call print
printcar 160,180,20,40
printcar 160,180,60,80

mov ah,0ch
mov al,38
mov bh,0


printcar 140,160,160,180 ;call print
printcar 140,160,200,220
printcar 120,140,180,200
printcar 120,140,220,240 ;call print
printcar 160,180,180,200
printcar 160,180,220,240 


ret

enemy_row3pos2 endp

enemy_row3pos3 proc

mov ah,0ch
mov al,0         ;;;; removing previous positions
mov bh,0

printcar 140,160,240,260 ;call print
printcar 140,160,280,300
printcar 120,140,260,280
printcar 120,140,300,320 ;call print
printcar 160,180,260,280
printcar 160,180,300,320 

printcar 140,160,160,180 ;call print
printcar 140,160,200,220
printcar 120,140,180,200
printcar 120,140,220,240 ;call print
printcar 160,180,180,200
printcar 160,180,220,240 


printcar 140,160,0,20 ;call print
printcar 140,160,40,60
printcar 120,140,20,40
printcar 120,140,60,80 ;call print
printcar 160,180,20,40
printcar 160,180,60,80

mov ah,0ch
mov al,40
mov bh,0


printcar 140,160,80,100 ;call print
printcar 140,160,120,140
printcar 120,140,100,120
printcar 120,140,140,160 ;call print
printcar 160,180,100,120
printcar 160,180,140,160 


ret

enemy_row3pos3 endp

enemy_row3pos4 proc

mov ah,0ch
mov al,0         ;;;; removing previous positions
mov bh,0

printcar 140,160,240,260 ;call print
printcar 140,160,280,300
printcar 120,140,260,280
printcar 120,140,300,320 ;call print
printcar 160,180,260,280
printcar 160,180,300,320 

printcar 140,160,160,180 ;call print
printcar 140,160,200,220
printcar 120,140,180,200
printcar 120,140,220,240 ;call print
printcar 160,180,180,200
printcar 160,180,220,240 

printcar 140,160,80,100 ;call print
printcar 140,160,120,140
printcar 120,140,100,120
printcar 120,140,140,160 ;call print
printcar 160,180,100,120
printcar 160,180,140,160 

mov ah,0ch
mov al,40
mov bh,0


printcar 140,160,0,20 ;call print
printcar 140,160,40,60
printcar 120,140,20,40
printcar 120,140,60,80 ;call print
printcar 160,180,20,40
printcar 160,180,60,80 


ret

enemy_row3pos4 endp


;///////////////////////////////////////
printScore proc
push ax
push bx
push cx
push dx

mov countDigit, 0
mov ax,point

pp:
inc countDigit
mov bl,10
div bl
 
mov cl,ah
mov ch,0
push cx

mov ah,0
cmp al,0
jne pp

lea si, total

scoring: 
pop ax 
add ax,'0'
mov [si],ax
inc si
inc si
dec countDigit
cmp countDigit,0
jne scoring

mov al,'$'
mov ah,0
mov [si],ax
pop dx
pop cx
pop bx
pop ax
ret
printScore endp

;;;;;;;;;;;MENU ANIMATION PROCS:::::::::::::::::::::::

printMenuCar proc 
pushAll
  
  mov ax,menuprev
  add ax,34
  mov menua, ax
  mov menuu, 90
  add ax,15
  mov menub,ax
  mov menuv ,98

  mov ah,0ch
  mov al,0
  mov bh,0
  print menua, menub, menuu, menuv
  
  mov ax,menuprev
  mov menua, ax
  
  add ax,47
  mov menub,ax
  mov menuv ,90
  mov menuu, 32

  mov ah,0ch
  mov al,0
  mov bh,0

  print menua,menub,menuu,menuv
  
  mov ax,menuprev
  add ax,22
  mov menua, ax
  mov menuu, 61
  add ax,11
  mov menub,ax
  mov menuv ,152

  mov ah,0ch
  mov al,0
  mov bh,0
  print menua,menub,menuu,menuv


  mov ax,menupos
  mov menua, ax
  mov menuu, 32
  add ax,47
  mov menub,ax
  mov menuv ,90

  mov ah,0ch
  mov al,190
  mov bh,0
  
  
  print menua,menub,menuu,menuv

  mov ax,menupos
  add ax,34
  mov menua, ax
  mov menuu, 90
  add ax,15
  mov menub,ax
  mov menuv ,98

  mov ah,0ch
  mov al,190
  mov bh,0
  print menua,menub,menuu,menuv

  mov ax,menupos
  add ax,22
  mov menua, ax
  mov menuu, 61
  add ax,11
  mov menub,ax
  mov menuv ,152

  mov ah,0ch
  mov al,98
  mov bh,0
  print menua,menub,menuu,menuv
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

printMenuCar2 proc
  pushAll
  mov ax,menupos
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
printMenuCar2 endp

;;;;;;;;;;;;;;Game over ;;;;;;;;;;;;;;;;;;;;;

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
print 256,260,104,109 ; R

print 252,258,112,120

popAll
ret
gameOver endp

end