public set_display_mode, display_ball

.model small

draw_row macro x
  local l1

mov ah,0ch  ; write or draw pixel
mov al,2   ; pltte 1 er 2 no ->magenta
mov cx,20
mov dx,x

l1:
int 10h
inc cx
cmp cx,40
jl L1
endm

draw_column macro y
local l2

mov ah,0ch
mov al,2    ; pltte 1 er 2 no ->magenta
mov cx,y
mov dx,20

l2:
int 10h
inc dx
cmp dx,40
jl l2
endm


.code
set_display_mode proc

mov ah,0  ; set mode
mov al,12h ; mode for 640x 480 pixels
int 10h
mov ah,0bh ; slect palette
mov bh,1   ;slect palette
mov bl,1   ; palett nmbr 1
int 10h

;;;;;;;;;;;;;;;;;;;

mov bh,0   ; slct backgrnd mode
mov bl,13  ;;;;;; col number (0-15)
int 10h

draw_row 20 ; draw a row in row 20
draw_row 40
draw_column 20 ; draw a column in col 20
draw_column 40
ret
set_display_mode endp

display_ball proc

mov ah,0ch
int 10h
inc cx
int 10h
inc dx
int 10h
dec cx
int 10h
dec dx
ret

display_ball endp
end



