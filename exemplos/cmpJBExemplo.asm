; Funções que o evandro falou na aula do dia 28/09/2020
; test, loop e CX, div,idiv,mul,cmp,jb,jmp, xor com ele mesmo limpa os bits
; Vamos testar as comparações e os "jumps", também conhecido como "branching"
segment code
..start:
	mov ax,data 
	mov ds,ax 
	mov ax,stack 
	mov ss,ax 
	mov sp,stacktop 

;
    xor ax, ax ; clear bytes, economiza no código
    mov bx, 3
    mov ax, 16
    cmp bx,ax ;op1-op2
    jb MENOR ; você faz |bx|-|ax| < 0
    jmp FIM
    
MENOR:
PRINT:
	mov ah,9 
	mov dx,msg_menor 
	int 21h  
FIM:
PRINT2:
	mov ah,9 
	mov dx,msg_fim 
	int 21h  
	mov ah,4ch 
	int 21h 

segment data
CR	equ	0dh 
LF	equ 0ah 


msg_menor db 'Oi, bx < ax',CR,LF,'$' 
msg_fim db 'FIM',CR,LF,'$' 

segment stack stack 
	resb 256 
	
stacktop: ; 