segment code
..start:
; Inicializacao
        mov ax, dados
        mov ds, ax
        mov ax, stack
        mov ss, ax
        mov sp, topopilha

; Zera todos os bits da porta 319h, inclusive
; o bit 7 para acertar direcao da porta 318h
; como saida e o bit 2 (RS) para entrar comando
        xor al, al
        mov byte[p319s], al
        mov dx, 319h
        out dx, al
        call delay
; ininializa o LCD
; Function Set = 8 bit interface, 2 line mode, 5x10 dot format
        mov al, 00111100b
        mov dx, 318h
        out dx, al
        call clk_enable
; limpa visor
        mov al, 00000001b
        mov dx, 318h
        out dx, al
        call clk_enable
; faz cursor piscar na tela
; Display On/Off & Cursor = Display On, Cursor Underline Off, Cursor Blink Off
        mov al, 00001100b
        mov dx, 318h
        out dx, al
        call clk_enable

; escreve: Sistemas Embarcados I
        call modo_dados

        xor bx,bx
        xor ah, ah
        mov cx, 21

sistema:
        mov al, [fraseini+bx]
        push ax
        call caracter
        inc bx
        loop sistema

; Prepara Shift
; zera 319h (coloca RS em zero)
        call modo_comando
        mov cx, 40
loopshift:
        push cx
        mov al,00011000b ; modo shift
        mov dx, 318h
        out dx, al
        call clk_enable
        pop cx
        loop loopshift

; Desce para a proxima linha
        call modo_comando
        mov al, 11000000b ; 80h = Set Display Adress + 40h Adress (line 2)
        mov dx, 318h
        out dx, al
        call clk_enable
        call delay

; Escreve Semestre 2012/2
        call modo_dados

        xor bx,bx
        xor ah, ah
        mov cx, 25

semestre:
        mov al, [frasefim+bx]
        push ax
        call caracter
        inc bx
        loop semestre


recebetecla:
        mov ah, 08
        int 21h

        cmp al, 's'
        je sai

        cmp al, 'l'
        je ligaled

        cmp al, 'd'
        je desligaled

        jmp recebetecla
;---------------------------------------------------------------------------
; funcao que liga luz de fundo (background led)
ligaled:
        mov al, byte[p319s]
        and al, 11111011b
        mov dx, 319h
        out dx, al
        jmp recebetecla
;---------------------------------------------------------------------------
; funcao que desliga luz de fundo (background led)
desligaled:
        mov al, byte[p319s]
        or  al, 00000100b
        mov dx, 319h
        out dx, al
        jmp recebetecla
;---------------------------------------------------------------------------
; funcao que imprime caracter no visor
; caracter em ASCII na pilha
caracter:
;   primeiro muda RS para 1 - modo dados
        call modo_dados
;   segundo coloca caracter no barramento
        mov bp, sp
        add bp, 2
        mov al, byte[ss:bp]
        mov dx, 318h
        out dx, al
        call clk_enable
        ret 2
;---------------------------------------------------------------------------
; funcao modo comando
; muda RS para zero
modo_comando:
        xor al, al
        mov byte[p319s], al
        mov dx, 319h
        out dx, al
        call delay
        ret
;---------------------------------------------------------------------------
; funcao modo dados
; muda RS para um
modo_dados:
        mov al, 01
        mov byte[p319s], al
        mov dx, 319h
        out dx, al
        call delay
        ret
;---------------------------------------------------------------------------
; funcao que retorna ao sistema operacional
sai:
        mov     ah,4ch
        int     21h
;---------------------------------------------------------------------------
; funcao que aguarda um tempo pre-determinado
delay:
        mov cx, 1; Carrega o valor 3 no registrador cx (contador para loop) ERA 200
del2:
        push cx; Coloca cx na pilha para usa-lo em outro loop
        mov cx, 0; Zera cx
del1:
        loop del1; No loop del1, cx eh decrementado seguidamente ate que volte a ser zero
        pop cx; Recupera cx da pilha
        loop del2; No loop del2, cx eh decrementado seguidamente ate que seja zero
        ret
;---------------------------------------------------------------------------
; funcao que levanta e abaixa o Enable (clock)
clk_enable:
        call delay
        mov al, byte[p319s]
        and al, 11111101b   ; abaixa Enable
        mov dx, 319h
        out dx, al
        call delay
        or  al, 00000010b   ; levanta Enable
        out dx, al
        call delay
        and al, 11111101b   ; abaixa Enable
        out dx, al
        call delay
        ret
;---------------------------------------------------------------------------
segment dados
p318s           db       0       ; variaveis para guardar as saidas
p319s           db       0
fraseini        db      'Sistemas Embarcados I' ; cx = 21
frasefim        db      'Semestre 2020/1 Arthur LB' ; cx = 25
;---------------------------------------------------------------------------
segment stack stack
    resb 256
topopilha:


