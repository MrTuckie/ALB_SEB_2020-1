.start:
; iniciar os registros de segmento DS e SS e o ponteiro de pilha SP
mov
ax,data
mov
ds,ax
mov
ax,stack
mov
ss,ax
mov
sp,stacktop
; codigo do programa
; aqui entram as instruções do programa
:
:
:
; Terminar o programa e voltar para o sistema operacional
mov
ah,4ch
int
21h
; definicao das variaveis
segment data
; Aqui entram as definições das variáveis do programa
:
:
:
; definição da pilha com total de 256 bytes
segment stack stack
resb 256
stacktop:
