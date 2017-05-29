.model small
.stack 100h

.data

.code
main  proc
      
mov ah,0
mov al,13h
int 10h

mov ah,0ch
mov al,128
mov bh,0
mov dx,0 ; row

box:
mov cx,0 ;column

L1:
int 10h
inc cx
cmp cx,60
jl L1

inc dx
inc bh
cmp dx,60

jl box	


main  endp
end   main