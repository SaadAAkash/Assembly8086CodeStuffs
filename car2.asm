.model small
.stack 100h

.data
   playerpos dw 2
   enemypos dw 1

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
;MOV     DX, 4240H

mov dx,4240h
MOV     AH, 86H
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
inc enemypos   ; at 1st,enemypos = 1 

cmp enemypos,4
je changeValue ; if greater than equ 4 , enem pos 1 
pushFlag       ;all value in stack 



call printgraph  ; the grid print

;;;;;;;;;this steadies the print;;;;;;;;;;;;
MOV     CX, 0FH
MOV     DX, 4240H
MOV     AH, 86H
INT     15H
popFlag
pushFlag

cmp enemypos , 1
je epos1
cmp enemypos , 2
je epos2
cmp enemypos , 3
je epos3

jmp enemyloop

epos1:
call enemy_pos_1
popFlag
jmp userloop
jmp enemyloop

epos2:
call enemy_pos_2
popFlag
jmp userloop
jmp enemyloop

epos3:
call enemy_pos_3
popFlag
jmp userloop
jmp enemyloop

;changeValue1:

;mov playerpos , 1
;jmp enemyloop

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
mov al,128
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
mov al,128
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
mov al,128
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

enemy_pos_1 proc

mov ah,0ch
mov al,0  ;;;; removing previous positions
mov bh,0

printcar 80,100,240,260 ;call print
printcar 80,100,280,300
printcar 60,80,260,280
printcar 60,80,300,320 ;call print
printcar 100,120,260,280
printcar 100,120,300,320 

printcar 140,160,240,260 ;call print
printcar 140,160,280,300
printcar 120,140,260,280
printcar 120,140,300,320 ;call print
printcar 160,180,260,280
printcar 160,180,300,320 

mov ah,0ch
mov al,128
mov bh,0

printcar 20,40,240,260 ;call print
printcar 20,40,280,300
printcar 0,20,260,280
printcar 0,20,300,320 ;call print
printcar 40,60,260,280
printcar 40,60,300,320 


ret

enemy_pos_1 endp

;;; enemy position 2 procedure ;;;;;;;;;;;;;;;;;;;;;

enemy_pos_2 proc

mov ah,0ch
mov al,0         ;;;; removing previous positions
mov bh,0



printcar 20,40,240,260 ;call print
printcar 20,40,280,300
printcar 0,20,260,280
printcar 0,20,300,320 ;call print
printcar 40,60,260,280
printcar 40,60,300,320 

printcar 140,160,240,260 ;call print
printcar 140,160,280,300
printcar 120,140,260,280
printcar 120,140,300,320 ;call print
printcar 160,180,260,280
printcar 160,180,300,320 

mov ah,0ch
mov al,128
mov bh,0

printcar 80,100,240,260 ;call print
printcar 80,100,280,300
printcar 60,80,260,280
printcar 60,80,300,320 ;call print
printcar 100,120,260,280
printcar 100,120,300,320 

ret

enemy_pos_2 endp

;;; enemy position 3 procedure ;;;;;;;;;;;;;;;;;;;;;

enemy_pos_3 proc

mov ah,0ch
mov al,0         ;;;; removing previous positions
mov bh,0



printcar 20,40,240,260 ;call print
printcar 20,40,280,300
printcar 0,20,260,280
printcar 0,20,300,320 ;call print
printcar 40,60,260,280
printcar 40,60,300,320 

printcar 80,100,240,260 ;call print
printcar 80,100,280,300
printcar 60,80,260,280
printcar 60,80,300,320 ;call print
printcar 100,120,260,280
printcar 100,120,300,320 

mov ah,0ch
mov al,128
mov bh,0


printcar 140,160,240,260 ;call print
printcar 140,160,280,300
printcar 120,140,260,280
printcar 120,140,300,320 ;call print
printcar 160,180,260,280
printcar 160,180,300,320 


ret

enemy_pos_3 endp

end   
