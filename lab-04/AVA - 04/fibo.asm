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
    
    push dx
    call imprimeNumero
    pop dx
    
    cmp dx, 0x000F ; compara com 8x16^4 (?), dependendo da flag q levantar, vai acionar a "branch" na prox linha
    ; o valor fica em dx sempre
    
    ; mov ah,9 ; se eu fizer isso, ax vai cagar os seu valor. preciso lidar com pilha;
    ; int 21h
    jl L10 ; se dx for menor que 0x8000, vai para L10:, se não continua, fazendo as paradas.
    


; AQUI TERMINA A EXECUCAO DO PROGRAMA PRINCIPAL (setup)

; As partes finais do código.
exit:
    mov dx,mensfim  ; mensagem de inicio
    mov ah,9
    int 21h
quit:
    mov ah,4CH ; retorna para o DOS com código 0
    int 21h

imprimeNumero:
    mov di,saida ; DI = destination index, usado para guardar o endereço (não precisa se preocupar em tirar por agora)
    push di ; joguei o valor na PILHA, ele está armazenado que nem no exemplo do vídeo.

    
    call bin2ascii
    mov dx,saida

    ; pop di
    mov ah,9
    int 21h

   

bin2ascii:
    push ax
    push bx
    
    mov si,4
    mov cx,5
    mov dx,ax  ; joga dx na parte em ax
    mov bx,10  ; salva o 10 para divid
volta:
    xor dx,dx
    div bx     ; dx pega o resto
    add dl,30h
    mov byte[saida+si],dl
    dec si

    loop volta
    
    pop bx
    pop ax
ret

segment dados ;segmento de dados inicializados
mensini:    db 'Programa que calcula a Serie de Fibonacci. ',13,10,'$'
mensfim:    db 'Valor final:',13,10,'$'
saida:      db '00000',13,10,'$'

segment stack stack
    resb 256
stacktop: