segment code
..start:
; iniciar os registros de segmento DS e SS e o ponteiro de pilha SP
    mov ax,data
    mov ds,ax
    mov ax,stack
    mov ss,ax
    mov sp,stacktop
    mov bx,two_chars
    xor ax,ax
; fim dos registros
    int 21h ; função do DOS de entrada de carcater. Retorna em AL
    mov[bx],al
    inc bx ; salvando em pilha, não pode ser al pois a pilha salva 16 bits, não 8
    int 21h 
    mov[bx],al
    mov dx,display_string ; agora ele pega o valor em display_string e joga para dx 
    
    mov ah,9 ; isso daqui é a cara de terminar o programa. 
    int 21h
; Terminar o programa e voltar para o sistema operacional
    mov ah,4ch 
    int 21h 

segment data
CR      equ     0dh ; declarou o cr
LF      equ     0ah ; declarou o lf
display_string  db   CR,LF ; falou que display string é um vetor de 2 bytes (cr,lf)
two_chars     resb 2 ; criou um buffer como tamanho 3 bytes
db  '$' ; criou a variável que eu não entendi ainda, mas não vou focar nela

segment stack stack 
    resb 256
stacktop: