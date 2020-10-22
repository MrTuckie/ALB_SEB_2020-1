; Código para multiplicação de dois vetores de words para um de double
; Aqui aprendemos a como andar nos vetores e usar loops


segment code
..start:
; iniciar os registros de segmento DS e SS e o ponteiro de pilha SP
	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax
	mov sp,stacktop
	
; criando loop
	mov cx,5
	mov bx,0
	mov si,0
volta:
	mov ax,word[vet1 + bx]
	mov di,word[vet2 + bx]
	mul di
	mov word[vet3 + si],ax
	mov word[vet3 + si+2],dx
	add si,4
	add bx,2
	loop volta
; Terminar o programa e voltar para o sistema operacional
	mov ah,4ch
	int 21h
segment data
vet1	dw	5,6,7,8,8
vet2	dw	2,2,2,2,2
vet3	dd	0,0,0,0,0
CR equ 0dh
LF equ 0ah
segment stack stack
	resb 256
stacktop:
