segment code ; linha em que começa o código mesmo
..start: ; se eu não me engano, isso é para o linkador (nasm) saber onde que começa o código
; iniciar os registros de segmento DS e SS e o ponteiro de pilha SP
	mov ax,data ; na linha que está "segment data", ele vai falar pra copiar o endereço de memória para ax
	mov ds,ax ; vai pegar o conteúdo de "ax" e vai jogar em "ds", o nosso registrador DATA SEGMENT
	mov ax,stack ; na linha que está "segment stack", ele vai falar pra copiar o endereço de memória para ax
	mov ss,ax ; vai pegar o conteúdo de "ax" e vai jogar em "ss", o nosso registrador STACK SEGMENT
	mov sp,stacktop ; na linha que está "stacktop", ele vai falar pra copiar o endereço de memória para sp
; fim da parte de iniciar os registradores (como se fosse o "setup(void){}" do arduino)

; o código do hello world (como se fosse o loop(void){} do arduino)
	mov ah,9 ; não saquei ainda, mas deve ter algo a ver com a execução.
	mov dx,mensagem ; salva onde tem a linha "mensagem" em dx
	int 21h ; chamada de interrupção do DOS, não foque nisso ainda.
	

; Terminar o programa e voltar para o sistema operacional
	mov ah,4ch ; tbm não sei pq ele fez isso, mas mandou 4c em hexa pra ah
	int 21h ; deve ser alguma chamada de kernel
	; assumo que isso seja algum pulo do gado pra realmente fazero programar fechar e voltar pra tela
	; int significa interrupção

; fim do código --------------

; início da parte de dados ---
segment data
; declarando as variáveis para pular linha e mostrar no terminal, eu acho.
CR	equ	0dh ; carrier return
LF	equ 0ah ; linefeed
; equ significa "definir uma constante e associando um nome a ela, no caso, CR e LF"

; declarando as variáveis que vão aparecer
mensagem db 'Oi, salve familia',CR,LF,'$' ; a mensagem que você quer escrever
; db significa "definir byte"
; como há 4 argumentos depois de db (o que está entre ''), então você define 4 bytes para essa label mensagem
; $, não entendi muito bem oq ele faz. Ele define o valor do contador de localização (ofsset) do segmento na posição em que ele for encontrado (??)
; len equ $ - mensagem     length of the string
segment stack stack ; linha em que começa o segmento da pilha (stack) e deu o nome de stack, mas poderia ser josé, se vc quiser.
	resb 256 ; aqui é a definição do tamanho (256 bytes) para a pilha
	; resp é um comando para declarar espaço de armazenamento não iniciado, reserva 64 bytes
stacktop: ; rótulo (label) para indicar onde que começa a pilha stack.