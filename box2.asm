.model small
.stack 100h
.data

 startx1 dw 0
 starty1 dw 0
 startx2 dw 0
 starty2 dw 0
 pageno dw 0

.code
main  proc
      
mov ax, @data
mov ds,ax


mov ah,0
mov al,12h ; 640*480 mode
int 10h

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov ah,0ch  ; write pixel
mov al,128  ; car color 

mov startx1 ,0
mov starty1,0
mov startx2,20
mov starty2,20
call printbox

mov startx1 ,20
mov starty1,20
mov startx2,40
mov starty2,40
call printbox
	


main  endp


;;;;;;;;;;;;;;;;;;;;;;;;;;

printbox proc

mov bh,0    ;page
mov dx,startx1 ; row

box:
mov cx,starty1 ;column

L1:
int 10h
inc cx
inc bh
cmp cx,starty2
jl L1

int 10h ;;;;;;;;;
inc dx
inc bh ;;;;;;;;;
cmp dx,startx2

jl box

ret
printbox endp
end   main
