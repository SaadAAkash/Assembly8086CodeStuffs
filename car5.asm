.model small
.stack 100h

.data
   playerpos dw 2
   ;enemypos dw 1

   enemyrow1pos dw 1 ; inc hwe 2 hbe game er start e
   enemyrow2pos dw -1 ; inc hwe 0 hbe
   enemyrow3pos dw -3 ; inc hwe -1 hbe

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

;######################################################

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


;###########################################
; code segment starts here ;;;;;;;;;;;;;;;;;;;;;;;;;;


.code 
    
    mov ax , @data ; data segment initialized
    mov ds,ax

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; Main Procedure ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main  proc

     
mov ah,0
mov al,13h   ;;;;;;;;;;;;;;;;;;;;;; 13 means 320 * 200 pixels
int 10h


;;;;;;;;;;;;;;;USER LOOP;;;;;;;;;;;;;;;;;;;;;;;;;


userloop:
inc playerpos   ; at 1st,playerpos = 2 

cmp playerpos,4
je changeValue ; if 4 , playerpos again back to 0 
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
jmp userloop


pos2:
call player_pos_2
popFlag
jmp enemyloop
jmp userloop

pos3:
call player_pos_3
popFlag
jmp enemyloop
jmp userloop


changeValue:

mov playerpos , 0
jmp userloop

;;;;;;;;;;;;;;;;;;;;;;ENEMY LOOP;;;;;;;;;;;;;;;;;;

enemyloop:
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



main  endp   ;;;;;;;;;;;;;NOTE: eikhane main endp ;;;;;;;;;;;;;;;;;;;;;;;;;

;####################################################

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

end   
