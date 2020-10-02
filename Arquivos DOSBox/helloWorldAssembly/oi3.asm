segment code
..start:
; iniciar os registros de segmento DS e SS e o ponteiro de pilha SP
    mov ax,data
    mov ds,ax
    mov ax,stack
    mov ss,ax
    mov sp,stacktop
;
    xor bx,bx ; bx = 0
    xor ax,ax ; ax = 0
    xor di,di ; di = 0 ; usarei bx e di como indexadores para andar no vetor.
L1:
    mov ax,[vetor1+bx] ; joga o valor do vetor1 em ax
    mul WORD[vetor2+bx] ; ax = ax*[vetor2+bx] ; faz a multiplicação e guarda em ax
    mov [vetor3+di],ax ; joga o valor no vetor3

    add bx,2 ; bx anda de 2 em 2 pq estamos lidando com words, e eles usam 2 bytes
    add di,4 ; di anda de 4 em 4 pq estamos lidando com doubles, e eles usam 4 bytes

    cmp bx,0x0A ; comparo se bx = 10, deve ter um jeito melhor de fazer isso
    je  FIM ; pulo para o fim se bx = 10.

    loop L1 ; repete o loop até satisfazer a saída

FIM
; Terminar o programa e voltar para o sistema operacional
    mov ah,4ch 
    int 21h 

segment data
CR      equ     0dh ; declarou o cr
LF      equ     0ah ; declarou o lf
vetor1     dw 1,2,3,4,5 ; aqui você pode brincar com os valores.
vetor2     dw 6,7,8,9,10 ;
vetor3     dd 0,0,0,0,0 ; lembre-se que aqui estamos declarando um double 

db  '$' ; criou a variável que eu não entendi ainda, mas não vou focar nela

segment stack stack 
    resb 256
stacktop: