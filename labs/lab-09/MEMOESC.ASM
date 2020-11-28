segment code
..start:
        mov ax, dados
        mov ds, ax
        mov ax, pilha
        mov ss, ax
        mov sp, topo

        xor     bx,bx
        mov     cx,5
        push    cx
l1:
        ; isso daqui deve iniciar o chip
        mov al, 10100110b
        mov dx, 319h
        out dx, al
        call    delay
        ; essa parte deve enviaro endereço
        mov al, [endereco] ; o endereço em si
        mov dx, 318h
        out dx, al
        call    delay

        ; isso daqui deve ser para o microprocessador entender
        mov al, 00000111b
        mov dx, 319h
        out dx, al
        call    delay

        mov al, 00000110b
        out dx, al
        call    delay

        ; o conteúdo que vai enviar o dado que é para imprimir
        
        mov     al,[dadomem+bx]
        mov     dx,318h
        out     dx,al
        call    delay
        pop     cx
        dec     cx
        inc     bx
        ; essa parte aqui deve ser dos sinais de entrada para avisar q é para escrever

        mov al, 00000010b
        mov     dx,319h
        out dx, al
        call    delay

        mov al, 00000110b
        out dx, al
        call    delay

        mov     al, 10100110b
        out     dx, al
        call    delay

        ; não sei ainda o que essa parte faz, mas é alguma interrupção
        mov     ah,0bh
        int     21h
        cmp     al,0
        jne     sai
        jmp     l1 ; volta para o inicio se for igual a zero

sai:
        mov     ah,01
        int     21h
        mov     ah,4ch
        int     21h

delay:
        mov     cx,100
del1: ; não sei oq isso faz ainda
        loop del1
        ret

segment dados
endereco      db      0x00
dadomem       db      'salve'

segment pilha stack
resb 100h
topo:



