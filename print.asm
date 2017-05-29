;ei code boi e ase 16 chaptr er 338 no page e :3

.MODEL SMALL
 .STACK 100H

 .DATA
    STRING_1  DB  'Assolam-o-Allikum$'
    STRING_2  DB  'Bangladesh Zindabad$'

 .CODE
   MAIN PROC
     MOV AX, @DATA  
     MOV DS, AX
     
     MOV AH, 0
     MOV AL,13H
     INT 10H
     
     mov ah,02h
     mov bh,0
     mov dh,0 ;2nd string er jnno row, value change kore kore dekhlei bujhbi
     mov dl,20;2nd string er jnno col, value change kore kore dekhlei bujhbi
     int 10h
     
     
      
     MOV AH, 9  
     LEA DX, STRING_1 
     INT 21H
     mov bl,3 ; ei part ta blue
     mov cx,1 ; color text print korar jnno
     int 10h  ; bt color hoyna!!! :(         
     
     
     

     MOV AH, 2                   
     MOV DL, 0DH
     INT 21H 
     
     
     mov ah,02h
     mov bh,0
     mov dh,0   ;2nd string er jnno row, value change kore kore dekhlei bujhbi
     mov dl,20  ;2nd string er jnno colum, value change kore kore dekhlei bujhbi
     int 10h
 
     MOV DL, 0AH                 
     INT 21H
     
     

     LEA DX, STRING_2            
     MOV AH, 9
     INT 21H

     MOV AH, 4CH                 
     INT 21H
   MAIN ENDP
 END MAIN