.model small
.stack 100h
.data
msg1 db 'Hello$'
.code
main proc
	mov ax,6
	int 10h
	mov ah,0ch
	mov al,1
	mov cx,301
	mov dx,100
li:
	int 10h
	inc cx
	cmp cx,600
	jle li
	mov ah,0
	int 16h
	mov ax,3
	int 10h
	mov ah,4ch
	int 21h

main endp
end main