# lab-02 de embarcados

Essa parte aqui é para entender o papel que o compilador faz em traduzir algo como:

"MOV destino, fonte" em 01001010101010101 (chutei um monte de número aqui só pra ilustrar)
Depois disso, vamos utilizar o debug para poder mostrar realmente que o que a gente escreveu como
0010101010101 em alguma instrução (ou se vc fez errado e deu mole,rapá)

A estrutura é com 6 bytes (48 bits no total), sendo cada byte responsável por algo em específico.
A contagem é da esquerda pra direita.

* Byte #1 = opcode
* Byte #2 = mod reg rm
* Byte #3 = lo desloc
* Byte #4 = hi desloc
* Byte #5 = lo data
* Byte #6 = hi data (nada faz sentido, mas vamos em frente e depois voltamos)

## Byte #1

Como cada byte tem 8 bits, o primeiro byte tem uma especificação em 8 bits.
do bit 7 ao 2 (6 bits) => responsável pelo "código da operação"
Quando o processador for executar esse código, ele vai saber qual operação realizar (soma, subtração, mov, etc)
bit 1 = D (Os professores não ajudam muito nas legendas)
bit 0 = W

Se W = 0 -> é uma instrução de byte
else: é uma instrução de word

Se D = 0 -> fonte da instrução especificada no campo REG (que eu acredito que seja no Byte #2, em algum dos bits dele)
else: destino da instrução no campo REG (mesma coisa acima)

(sim, em um a gente começou contando os bits de 0 a 7, no outro, a gente começou a contar do 1 ao 6. Nada faz sentido)

MASSSS ARTHURRRRRRRRRR!!! Como que eu sei qual é o código da operação????<
Dê uma olhada no final do datasheet do microprocessador que é sucesso

## Byte #2

mod reg r/m

* O mod (modo), ainda não saquei o que é. Mas alguma hora eu descubro. Por enquanto, o certo parece ser 11.
* reg é o registrador q vc define se vai ser fonte ou destino
* r/m é meio q "de registrador pra memória (salvar/save)" ou "da memória pra registrador (carregar/load)"

## Byte #3

Ninguém se importa com outros bytes, vamos trabalhar com os acima apenas.

## A parte "prática"

### editando os segmentos de memória (ds, es e ss)

Você tem que adicionar um offset de 16 bytes entre os ponteiros. Se eu estiver certo, acredito que
seja  adicionar 80 em hexa decimal a partir do ponteiro.
CS (no meu computador, no de vocês podem variar) = 0x0760
DS = CS + 0x0080 = 0x07E0
ES = DS + 0x0080 = 0x0860
SS = ES + 0x0080 = 0x09E

(Essa parte eu posso estar errado, tenho que conferir depois)

### criando o mov

olhando no datasheet, nós podemos ver que o código para a função "mov" é
1000'10DW (esse D W é o que a gente viu lá no início)
De exemplo, vamos fazer "mov ax, bx"
Como ax é o Destino e é o REG e estamos mexendo com WORDS, então:
D = 1 (pois ax é o reg de destino)
W = 1 (pois estamos mexendo com WORDS)
então o primeiro byte vai ser 1000'1011, que em Hexa, é 0x8B

Para o segundo byte, admitindo o mod = 11 (porque não estamos mexendo com deslocamentos e pra facilitar a nossa vida), olhamos que, para W = 1, o REG tem que ser 000 para que a gente informe que estamos lidando com o AX.
A fonte, no caso, r/m, é BX. Para o caso de mod = 11 e (and) W = 1, vemos que r/m tem que ser 011 para dar BX como fonte.

Então, o nosso byte 2 fica assim: 1100'0011, que em hexa é 0xC3.

## Fazendo sentido

Agora, nós temos que escrever isso na memória quase na que "mão", no caso, no endereço, CS:IP (porque é onde fica o código em si).
Para fazer isso vamos usar o comando ecs:0100 (pois IP = 0100) (para o primeiro byte) e ecs:0101 (para o segundo byte)
-ecs:0100
8b
-ecs:0101
c3

Para verificar se fez certo, faça:
-ucs:0100
E deverá aparecer mov ax,bx na primeira linha.

Vou continuar a fazendo uns exemplos aqui, vc pode pular pro próximo, se quiser.

mov ax,[bx] ; que pega o que tem no endereço correspondente ao número BX, e não o valor contido em bx e joga pra ax.

mov,d=1,w=1 -> 1000'1011 8b.
mod,reg,r/m -> 0000'0111 07.

### Eu não vou fazer alguns exercícios da parte prática

Tem uns que ele falou que não era pra fazer mesmo, então to nem aí, fi.

### mov ax,[1000]

bora testar
