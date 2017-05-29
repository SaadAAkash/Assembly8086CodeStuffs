this is the writeint example from the web
Title This program uses the code from the Writeint Procedure    

; Writes a 16-bit unsigned binary integer to standard 
; output. Input parameters: AX = value, BX = radix.

.model small
.286
.stack 100h
.data
buffer   db  16 dup(' ')             ; buffer to hold chars
xtable   db  '0123456789ABCDEF'      ; translate table

.code
extrn clrscr:proc, crlf:proc
main proc
     mov ax,@data
     mov ds,ax

     mov ax,100h                                ;set ax to number to write     
     mov bx,10                          ;base 10 output
     call wrint
    
     mov ax,4c00h                               ;normal termination
     int 21h

main endp     


wrint proc     
     mov   di,0456h                     ;initialize di reg
     pusha                                      ;push all regs onto stack

L3:  mov   dx,0                         ; clear dividend to zero
     div   bx                           ; divide AX by the radix
    
     
     xchg  ax,dx                        ; exchange quotient, remainder
     push  bx                   
     mov   bx,offset xtable             ; translate table
     xlat                               ; look up ASCII digit
     pop   bx              
     dec   di                           ; back up in buffer
     mov   [di],al                      ; move digit into buffer
     xchg  ax,dx                        ; swap quotient into AX

     inc   cx                           ; increment digit count
     or    ax,ax                        ; quotient = 0?
     jnz   L3                           ; no: divide again

; Display the buffer using CX as a counter.

     call clrscr
L4:  mov   ah,2                         ; function: display character
     mov   dl,[di]                      ; character to be displayed 
     int   21h                          ; call DOS
     inc   di                           ; point to next character
     loop   L4
     call crlf

     popa                                       ;pop all regs from stack
     ret
wrint endp       
 
end main