; Código feito por Ricardo e Arthur.
;==================================
;CODIGO
;================================== 
segment code
..start:
;
;==================================
;CONFIGURANDO SEGMENTOS
;==================================
	mov ax, dados
	mov ds, ax
	mov ax, stack
	mov ss,ax
	mov sp,stacktop
;
;==================================
;PROGRAMA PRINCIPAL
;================================== 
	mov dx, mensini; mensagem de inicio
	mov ah,9
	int 21h


	mov ax,0; primeiro elemento da serie
	mov bx,1; segundo elemento da serie
L10:
;-------------------------------------------------------
 ;Se quiser imprimir a sequencia toda tire o comentario
 ;da linha abaixo:
 
;--------------------------------------------------------
	mov dx,ax; tomo o ultimo elemento
	add dx,bx; calcula novo elemento da serie
	mov ax,bx; atualizo o ultimo elemento
	mov bx,dx; atualizo o novo elemento da serie 

	call imprimirBX 

	cmp dx,  0x8000 ; condicao de parada
; Nessa parte do código aqui, a variável que é comparada é DX.
; Lembre-se, ao executar essa parte, bx possui o último valor da sequência.
; bx é a variável que vai ser printada
; ax possui o penultimo valor da sequencia
; dx é a variável auxiliar que fica variando e serve para comparar.


	jb L10; salto de loop
;-------------------------------------------------
; AQUI TERMINA A EXECUCAO DO PROGRAMA PRINCIPAL
;------------------------------------------------
exit:
	call imprimirBX
	mov dx,mensfim; mensagem de fim
	mov ah,9
	int 21h
quit:
	mov     ah,4CH ;retorna para o DOS com código 0
	int     21h
;
;==================================
;DEFINICAO DE FUNCOES
;==================================
;
imprimirBX:
;---------------------
;	Salvando as variáveis na pilha para poder pegar depois.
;---------------------
	push dx
	push ax
;---------------------
;	Executando Funcao
;---------------------
	call bin2ascii ; chamada de função para converter

	mov dx, saida  ; essas três linhas são responsáveis por imprimir na tela o valor de 'saída'
	mov ah, 9	   ; a impressão é sempre feita olhando a tabela ASCII
	int 21h



    mov dx, saida2  ; essas três linhas são responsáveis por imprimir na tela o valor de 'saída'
	mov ah, 9	   ; a impressão é sempre feita olhando a tabela ASCII
	int 21h

;---------------------
;	Recuperando as variáveis que você guardou na pilha acima. Deve ser feito na ordem certa.
;---------------------
	pop ax
	pop dx
ret ; isso daqui, se eu não me engano, informa para onde tem que voltar na chamada da função do código.
;
;==================================

; Função para converter binário em ascii

bin2ascii:
;---------------------
;	Salvando as variáveis na pilha para poder pegar depois.
;---------------------
	push si
	push cx
	push dx
	push ax
	push bx
;---------------------
; Executando Funcao
;---------------------
	mov si, 4	; responsável por andar dentro do vetor 'saida' de 5 doubles
	mov cx, 5	; variável que automaticamente decrementa depois que passa em loop (counter register)
	mov ax, bx  ; Preparando numerdor da divisao. ax recebe o ultimo valor da sequência que está em bx
	mov bx, 10 ; Preparando Denominador, bx = 10 agora.

	; A lógica aqui explicada na aula é que vamos dividir todo os números e somar por '0'.
	; somar por '0' é o mesmo que somar por 48 (dec) ou por 30h. Ao fazer isso, você decompoe o número
	; e traduz ele para ascii.
	; Dê uma olhada na tabela para sacar a lógica.
	; http://www.asciitable.com/

 voltabin2asci: ; esse loop é responsável por fazer a tradução no vetor inteiro

	xor dx,dx ;	Zerando a parte superior do registrador de 32bits
	div bx ; Dividindo DX:AX por 10 faz o resto ficar em DX e o quociente em AX
	add dl, '0' ; Convertendo pra ASCII (a soma por '0' q eu falei ali em cima)
	mov byte[saida+si], dl; Jogando o valor de dl (que contem o valor binário já convertido para ascii) no vetor saída
	mov byte[saida2+si], dl
	; primeira iteração
	; saida2 = '00001'
	dec si; Andando no vetor de saida (escreve o número da direita para esquerda)
	loop voltabin2asci

	mov si,0

loop2:
	cmp byte[saida2+si], '0' ; '00001'
	jne label_nome
	mov byte[saida2+si], ' ' ; '    1'
	inc si ; si = 4
	loop loop2

label_nome:


;------------------------
; Recuperando os valores originais que você salvou anteriormente
;------------------------
	pop bx
	pop ax
	pop dx
	pop cx
	pop si
ret
;==================================
;
;==================================
;SEGMENTO DE DADOS
;==================================
segment dados ;segmento de dados inicializados
	mensini:  db   'Programa que calcula a Série de Fibonacci.',13,10,'$'
	mensfim:  db   'bye',13,10,'$'
	saida:    db   '00000','$'

	saida2:    db   '00000',13,10,'$'
;==================================
;SEGMENTO DE PILHA
;==================================
segment stack stack
	resb 256; reserva256 bytes para formar a pilha
stacktop: ; posição de memória que indica o topo da pilha=SP
