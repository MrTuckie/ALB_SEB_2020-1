segment code
..start:
	mov ax,data 
	mov ds,ax 
	mov ax,stack 
	mov ss,ax 
	mov sp,stacktop 


PRINT:
	mov ah,9 
	mov dx,mensagem 
	int 21h 
	mov ah,4ch 
	int 21h 
	
segment data
CR	equ	0dh 
LF	equ 0ah 


mensagem db 'Oi, salve familia',CR,LF,'$' 

segment stack stack 
	resb 256 
	
stacktop: ; 