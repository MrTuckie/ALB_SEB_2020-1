segment code
..start:
	mov ax, dados
	mov ds, ax
	mov ax, stack
	mov ss,ax
	mov sp,stacktop
; AQUI COMECA A EXECUCAO DO PROGRAMA PRINCIPAL
	mov dx,mensini ; mensagem de inicio
	mov ah,9
	int 21h
	mov ax,0 ; primeiro elemento da série
	mov bx,1 ; segundo elemento da série
L10:
	mov dx,ax
	add dx,bx ; calcula novo elemento da série
	mov ax,bx
	mov bx,dx
	call imprimenumero ;chamando imprime numero
	cmp dx, 0x8000
	jb L10
	
	
; AQUI TERMINA A EXECUCAO DO PROGRAMA PRINCIPAL
exit:
	mov dx,mensfim ; mensagem de inicio
	mov ah,9
	int 21h
quit:
	mov ah,4CH ; retorna para o DOS com código 0
	int 21h	
;funcao imprime numero
imprimenumero:
	;empilhando para nao perder
	push ax
	push bx
	push dx
	mov di,saida
	call bin2ascii
	mov dx, saida
	mov ah,9
	int 21h
	;desimpilhando para nao perder
	pop dx
	pop bx
	pop ax
	ret ; recupera contexto

; fucao bin2ascii
bin2ascii:
	mov ax,dx ;colocando o resultado da serie em ax
	mov bx,10 ;divisor
	mov si,4 ;posicao do vetor
	mov cx,5 ; loop
volta: 
	xor dx,dx ;zerando valor de dx
	div bx
	add dl,0x30 ;30hexa
	mov byte[saida + si],dl
	dec si ;subtrai 1 de si
	loop volta
	ret
	
segment dados ;segmento de dados inicializados
mensini: db 'Programa que calcula a Série de Fibonacci. ',13,10,'$'
mensfim: db 'bye',13,10,'$'
saida: db '00000',13,10,'$'
segment stack stack
	resb 256 ; reserva 256 bytes para formar a pilha
stacktop: ; posição de memória que indica o topo da pilha=SP
