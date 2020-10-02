segment code
..start:
; iniciar os registros de segmento DS e SS e o ponteiro de pilha SP
    mov ax,data
    mov ds,ax
    mov ax,stack
    mov ss,ax
    mov sp,stacktop
    mov bx,three_chars ; joga o valor do buff three_chars em bx para poder acumular os valores
    mov ah,1 ; a principio, não entendi o pq q ele fez isso.
; fim dos registros
    int 21h ; função do DOS de entrada de carcater. Retorna em AL
    dec al ; decrementa o valor contido em al => al = al - 1
    mov[bx],al ; salva o valor de al direto no endereço de bx (bx contem o valor de al)
    inc bx ; incrementa o valor contido em bx em 1;
    ; o maluco repete isso 2x
    int 21h 
    dec al
    mov[bx],al
    inc bx

    int 21h
    dec al 
    mov[bx],al

    mov dx,display_string ; agora ele pega o valor em display_string e joga para dx 
    
    mov ah,9 ; isso daqui é a cara de imprimir algo
    int 21h
; Terminar o programa e voltar para o sistema operacional
    mov ah,4ch 
    int 21h 

segment data
CR      equ     0dh ; declarou o cr
LF      equ     0ah ; declarou o lf
display_string  db   CR,LF ; falou que display string é um vetor de 2 bytes (cr,lf)
three_chars     resb 3 ; criou um buffer como tamanho 3 bytes
db  '$' ; criou a variável que eu não entendi ainda, mas não vou focar nela

segment stack stack 
    resb 256
stacktop: