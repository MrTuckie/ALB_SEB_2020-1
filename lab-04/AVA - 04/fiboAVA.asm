 segment code
..start:
; setup
    mov ax, dados
    mov ds, ax
    mov ax, stack
    mov ss,ax
    mov sp,stacktop
; AQUI COMECA A EXECUCAO DO PROGRAMA PRINCIPAL
    mov dx,mensini ; mensagem de inicio
    mov ah,9
    int 21h
; comecando fibonacci
    mov ax,0 ; primeiro elemento da série
    mov bx,1 ; segundo elemento da série
L10:
    mov dx,ax   ; joga o primeiro elemento da série em dx
    add dx,bx   ; calcula novo elemento da série (dx = dx+bx)
    mov ax,bx   ; joga o valor do segundo elemento no primeiro
    mov bx,dx   ; joga o valor do elemento somado no segundo elemento
    cmp dx, 0x8000 ; compara com 8x16^4 (?), dependendo da flag q levantar, vai acionar a "branch" na prox linha
    
    jb L10 ; se dx for menor que 0x8000, vai para L10:, se não continua, fazendo as paradas.

; As partes finais do código.
exit:
    mov dx,mensfim  ; mensagem de inicio
    mov ah,9
    int 21h
quit:
    mov ah,4CH ; retorna para o DOS com código 0
    int 21h

segment dados ;segmento de dados inicializados
mensini:    db 'Programa que calcula a Serie de Fibonacci. ',13,10,'$'
mensfim:    db 'bye',13,10,'$'
saida:      db '00000',13,10,'$'

segment stack stack
    resb 256
stacktop:
