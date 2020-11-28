; Código feito por Arthur Lorencini Bergamaschi 2016101335 - turma 06.3 
segment code
..start:
	mov ax,dados
	mov ds,ax
	mov ax,stack
	mov ss,ax
	mov sp,stacktop

; Parte principal do código já discutido em aula

	mov dx,nome
	mov ah,9
	int 21h

	mov ax,0
	mov bx,1

L10:
    
	mov dx,ax 
	add dx,bx 
	mov ax,bx
	mov bx,dx
    call imprimenumero 
	cmp dx,28657 ; valor que estava no pdf

; Nessa parte do código aqui, a variável que é comparada é DX.
; Lembre-se, ao executar essa parte, bx possui o último valor da sequência.
; bx é a variável que vai ser printada
; ax possui o penultimo valor da sequencia
; dx é a variável auxiliar que fica variando e serve para comparar.
	jb L10; salto de loop
    ; fim do programa principal. Daqui pra baixo é declaração de funções e saídas do programa.
quit:
	mov     ah,4CH ;retorna para o DOS com código 0
	int     21h


; Definindo as funções imprimenumero e bin2ascii

imprimenumero:
;salvando as variáveis na pilha para poder pegar depois.
	push dx
	push ax

;executando a função em si
	call bin2ascii  ; chamada de função para converter
	mov dx,saida    ; essas três linhas são responsáveis por imprimir na tela o valor de tudo.
                    ; como eu não coloquei '$' no final de saída, ele vai imprimir tudo até saidalimpa
                    ; esse é o PULO DO GATO, professor. 
	mov ah,9	    ; a impressão é sempre feita olhando a tabela ASCII
	int 21h
;---------------------
;recuperando as variáveis que você guardou na pilha acima. Deve ser feito na ordem certa.

	pop ax
	pop dx
ret ; isso daqui, se eu não me engano, informa para onde tem que voltar na chamada da função do código.


; Função para converter binário em ascii já discutida nas aulas anteriores.

bin2ascii:

;salvando as variáveis na pilha para poder pegar depois.

	push si
	push cx
	push dx
	push ax
	push bx

; a função em si
	mov si,4	; responsável por andar dentro do vetor 'saida' de 5 doubles (0 a 4)
	mov cx,5	; variável que automaticamente decrementa depois que passa em loop (counter register)
	mov ax,bx   ; ax recebe o ultimo valor da sequência que está em bx
	mov bx,10   ; bx = 10 agora.

	; A lógica aqui explicada na aula é que vamos dividir todo os números e somar por '0'.
	; somar por '0' é o mesmo que somar por 48 (dec) ou por 30h. Ao fazer isso, você decompoe o número
	; e traduz ele para ascii.
	; Dê uma olhada na tabela para sacar a lógica.
	; http://www.asciitable.com/

    voltabin2asci: ; esse loop é responsável por fazer a tradução no vetor inteiro

        xor dx,dx   ; zerando dx
        div bx      ; dividindo por bx
        add dl,'0'  ; convertendo para ascii (a soma por '0' q eu falei ali em cima)
        mov byte[saida+si],dl   ; jogando o valor de dl (que contem o valor binário já convertido para ascii) no vetor saída
        mov byte[saidaLimpa+si],dl ; aproveitando e colocando na 'saidaLimpa' também.
        dec si      ; andando no vetor de saida (escreve o número da direita para esquerda)
        loop voltabin2asci

    mov si,0	; responsável por andar dentro do vetor 'saida' de 5 doubles
	mov cx,5	; variável que automaticamente decrementa depois que passa em loop (counter register)
    
; A lógica é a seguinte, ele vai andar da esquerda da direita pra matar os zeros a esquerda.
; se algum elemento do saidaLimpa conter zeros a esquerda, ele substitui. Se ele achar um número diferente de zero
; ele termina com o loop (de maneira preguiçosa)

    isZero:
        cmp byte[saidaLimpa+si],'0' 
        jne l20  ; pula para l20 se for diferente de 0
        mov byte[saidaLimpa+si],' ' ; colocando o space onde tem zero.
        inc si ; andando da esquerda pra direta agora.
        loop isZero
    l20: ; não achei um nome bom o suficiente para colocar aqui
        mov cx,0 ; terminando o loop de maneira preguiçosa

; recuperando o conteúdo salvo na pilha
	pop bx
	pop ax
	pop dx
	pop cx
	pop si
ret

segment dados ;segmento de dados inicializados
    nome:     db   9,9,'EP-Sistemb1 - Arthur Lorencini Bergamaschi - Turma 06.3',13,10,'$'
    saida:    db   '00000' ; não coloquei $ para que a chamada da int21 imprima até o final. Esse é o pulo do gato.
    linha:    db   ' <---> ' ; o mesmo vale aqui.
    saidaLimpa: db 32,32,32,32,32,13,10,'$' ; 32 = spacebar na tabela ascii

segment stack stack
	resb 256
stacktop:
