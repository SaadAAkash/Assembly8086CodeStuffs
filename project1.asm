extrn scan_code:byte, key_flag:byte
public keyboard_int


.model small
.stack 100h
.data
.code

keyboard_int proc
	
push ds ; save reg
push ax
	
mov ax, seg scan_code
mov ds,ax ; ds value setup

;input scan strats here

in al,60h
push ax
in al,61h
mov ah,al
or al,80h
out 61h,al
xchg ah,al
out 61h,al
pop ax
mov ah,al
test al,80h
jne key_0

;make code

mov scan_code,al
mov key_flag,1

key_0:

mov al,20h
out 20h,al

;restore reg
pop ax
pop ds
iret
keyboard_int endp

end