; Descrição do código:
; Enviar comandos no teclado para fazer o motor ir de um lado ao outro.
; Enviar comandos no teclado para acender ou apagar um led na placa do projeto.
; 318h é uma porta bidirecional, bit 7 da 319h é responsável por definir.
; S7 = 0 -> 318h = saída; S7 = 1 -> 318h = Entrada
; 318h é responsável por controlar o motor.
; 319h Entrada é responsável por ler as variáveis.
; As instruções de 'in' vão direto pra 319h Entrada
; As instruções de 'out' vão direto pra 319h Saída
; 319h é a porta de entrada (8bits) e tem outra parte de saída tbm (7bits)


; Sobre as flags https://www.ic.unicamp.br/~celio/mc404-2006/flags.html


; Instruções in, out, test, jz, jnz, xlatb

; in <destino>, <porta>
; out <porta>, <origem>
; test <reg>, <value>
; a função teste altera as flags lá e serve para fazer o jump logo em seguida
; eu acredito que a flag é ZF, e por isso que deve ser jz, de jump z, Z é de Zero.
; xlatb: Table Look-up Translation equivale a fazer MOV AL,[BX+AL]
        
; https://www.felixcloutier.com/x86/xlat:xlatb
segment code
..start:
	; Inicializacao
        mov 	ax, data
        mov 	ds, ax
        mov 	ax, pilha
        mov 	ss, ax
        mov 	sp, topo
	
        mov 	al, 0 ; Zera todos os bits da porta 319h, inclusive 
        mov 	dx, 319h ; o bit 7 para acertar direcao da porta 318h, bit 7 = 0 -> 318H saída
        out 	dx, al

        mov byte [teste], 0  ; O motor j� come�a a se mover para a direita
volta:  
        mov     dx, 319h
        in      al, dx

        test    al, 1   ; testa se a chave foi acionada
        jz      esquerda ; pula se for zero

        test    al, 4   ; testa se a chave foi acionada
        jz      direita ; pula se for zero

        test    al, 2   ; testa sei lá oq e pede para sair
        jnz     sair    ; pula se for um (ou not zero)

segue:
        and     byte[p1],3  ; Mantem os dois bits menos significativos de p1 (?????)
        mov     al, [p1]
        mov     bx, fases
        xlatb               ; Usa al (p1) como offset (indice) na tabela de fases e retorna dado em al
        and     al, 0x1f
        mov     dx, 318h
        out     dx, al      ; Escreve na porta 318h

        call    delay       ; Pula para rotina que cria atraso

        cmp     byte[teste], 0
        je      decrementa
        jmp     incrementa
incrementa:
        inc     byte[p1]
        jmp     testatecla
decrementa:
        dec     byte[p1]
testatecla:        

        mov     ah, 0bh ; deve ser a interrupção que vê se chegou alguma tecla e salva ela em al.
        int     21h     ; http://spike.scu.edu.au/~barry/interrupts.html#ah0b

        cmp     al, 0   ; Se nenhuma tecla foi pressionada, repete programa
		je	volta 

        mov 	ah, 08 ;
        int 	21h

        cmp	al, 's'  ; Se tecla s foi pressionada, sai do programa
                je      sair    

        cmp	al, 'e'  ; Se tecla s foi pressionada, motor deve se mover para a direita
                je      esquerda  

	cmp	al, 'd'  ; Se tecla s foi pressionada, motor deve se mover para a esquerda
                je      direita   
        jmp	volta 
direita:
        mov     byte[teste], 0
        jmp     segue

esquerda:
        mov     byte[teste], 1
        jmp     segue

sair:
        mov     dx, 318h
        xor     ax, ax
        out     dx, al
        mov     ah,4ch
        int     21h

delay:
        push	cx
        mov 	cx, 15		; Carrega o valor 3 no registrador cx (contador para loop)

del2:
        push 	cx			; Coloca cx na pilha para usa-lo em outro loop
        mov 	cx, 0		; Zera cx

del1:
        loop 	del1		; No loop del1, cx eh decrementado seguidamente ate que volte a ser zero
        pop 	cx			; Recupera cx da pilha
        loop 	del2		; No loop del2, cx eh decrementado seguidamente ate que seja zero
        pop		cx
        ret     

segment data
        fases db 1010b, 0110b, 0101b, 1001b	; Tabela de fases
        p1 db 0				        ; Indice para tabela de fases motor1
        teste db 0                              ; Que porra é essa de teste, marreco?
segment pilha stack
        resb 100h
topo:
