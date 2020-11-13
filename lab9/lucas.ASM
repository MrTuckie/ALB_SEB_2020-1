segment code
..start:
        mov ax, dados
        mov ds, ax
        mov ax, pilha
        mov ss, ax
        mov sp, topo
		mov si,0 ;zera o si
l1:
        mov al, 10100110b
        mov dx, 319h
        out dx, al
        call    delay

        mov al, [endereco]
		inc byte[endereco]
        mov dx, 318h
        out dx, al
        call    delay

        mov al, 00000111b
        mov dx, 319h
        out dx, al
        call    delay

        mov al, 00000110b
        out dx, al
        call    delay

;inserindo minha informação
        mov     al,byte[dadomem+si]
        mov     dx,318h
        out     dx,al
        call    delay

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
		
		;se o ultimo caracter for '$' ele sai
		inc si ;prox caracter
		cmp byte[dadomem + si], '$'
		jnz l1 
sai:
        mov     ah,4ch
        int     21h

delay:
        mov     cx,100
del1:
        loop del1
        ret

segment dados
endereco      db      0x0
dadomem       db      "Lucas","$"

segment pilha stack
resb 100h
topo:


