# lab-02 de embarcados

*Confira a pasta 'imgs' com as fotos pra enteder melhor*  
Este laboratório é para entender o papel que o compilador faz em traduzir algo como 'mov ax,bx' (linguagem em assembly) para binário/hexadecimal (no fundo, no fundo, é tudo binário). Nós vamos imitar o papel do compilador e escrever diretamente na memória da máquina (do DOSBox) os valores em hexadecimal correspondente as instruções do tipo 'mov'.  

O intuito disso é aprender que a máquina pega o nosso código em assembly e transforma em binário e salva dentro da memória.

## Glossário

0x1234 = 1234H **Isso é convenção para indicar que o número está em hexadecimal**  

1 parágrafo = 16 bytes  = 128 bits  
1 word (em geral) = 2 bytes = 16 bits  
1 byte = 8 bits  
1 nibble = meio byte = 4 bits. Uma letrinha em hexadecimal ocupa 1 nibble (pois 2^4 = 16)

Como a memória é mapeada usando 0x00000 (5 campos em hexadecimal), nós falamos que ela é composta de 5 nibbles. É sempre bom ter isso na cabeça.  
BUT, os registradores são sempre de 0x0000, 4 nibbles, ou seja, 16 bits.  Lembre-se disso.  

## Estrutura das instruções

A estrutura é com 6 bytes (48 bits no total), sendo cada byte responsável por algo em específico.
A contagem é da esquerda pra direita. Na prática, apenas os dois ou três primeiros bytes são importantes.  

* Byte #1 = opcode
* Byte #2 = mod reg rm
* Byte #3 = lo desloc (não se preocupe)
* Byte #4 = hi desloc (não esquenta)
* Byte #5 = lo data (ignore)
* Byte #6 = hi data (deixa quieto, não é importante agora)

### Byte #1 - opcode, em geral

Como cada byte tem 8 bits, o primeiro byte tem uma especificação em 8 bits.
Do bit 7 ao 2 (6 bits) => responsável pelo "código da operação", também chamado de 'opcode'.
Quando o processador for executar esse código, ele vai saber qual operação realizar (soma, subtração, mov, etc)  

Os outros bits são responsáveis por dizer algumas coisas sobre os 'argumentos' das instruções. Serve pra dizer se o 'ax' em 'mov ax,[bx]' é um registrador que vai receber um valor ou vai enviar um valor. Entende?  

bit 1 = D  (de destino)
bit 0 = W  (de word, palavra)  

**Se** D = 0 -> o registrador especificado no campo "REG" (veremos mais tarde) será a fonte de informação (se ele vai ficar no lado direito do 'mov destino,**fonte**)
**Caso contrário**: o registrador especificado no campo "REG" será para a onde a informação destinará (se ele vai ficar no lado esquerdo do 'mov **destino**,fonte')  

Se W = 0 -> é uma instrução está mexendo com bytes (ah, al, que possuem 8 bits)
else: é uma instrução está mexendo com words (ax,bx,dx, que possuem 16bits)
(sim, em um a gente começou contando os bits de 0 a 7, no outro, a gente começou a contar do 1 ao 6. Nada faz sentido)

MASSSS ARTHURRRRRRRRRR!!! Como que eu sei qual é o código da operação????<
Dê uma olhada no final do datasheet do microprocessador que é sucesso

### Byte #2 - mod, reg, r/m

* O mod é o "modo" (jeito ou maneira de realizar a ação) que você realiza as instruções. Se você for usar uma instrução que lida entre registradores, o 'mod' é um valor. Se você usar instruções que pegam informação de registrador para jogar na memória RAM, é outro, e assim vai.
* 'reg' é o registrador q vc define se vai ser fonte ou destino, é o que a gente falou lá em cima.
* r/m é meio q "de registrador pra memória (salvar/save)" ou "da memória pra registrador (carregar/load)". Meio complexo de entender, mas não se preocupe.

### E os bytes restantes

Ninguém se importa com outros bytes por agora. Vamos trabalhar com os acima apenas.

## A parte "prática"

### editando os segmentos de memória (ds, es e ss)

**Nessa parte, você não precisa se preocupar muito.** Aqui vamos apenas adicionar 0x0001 ao valor de DS (que costuma ser igual ao de CS no início). Ao fazer isso, quando o computador for ver onde que realmente fica a memória, ele vai dar um shift left (ou também multiplicar por 16).  

Exemplo:

CS = 0x075F (é um registrador de 16 bits, 4 nibbles, meio byte)  
Na memória, o endereço é de 5 nibbles, ou seja ele vai virar 075F0. Fazer isso é multiplicar por 16 (se eu não me engano)  
Se você fizer DS = CS + 1, DS = 0x0760. Quando a memória for endereçar, ela vai deslocar para esquerda (ela faz isso por decisão da intel, isso é invisível para a gente, por isso q vc n tem q se preocupar tanto). Ou seja, DS (para mapear a memória) vira 0

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
Para fazer isso vamos usar o comando ecs:0100 (pois IP = 0100) (para o primeiro byte) e ecs:0101 (para o segundo byte).  

-ecs:0100  
8b  
-ecs:0101  
c3  

Para verificar se fez certo, faça:
-ucs:0100  
E deverá aparecer mov ax,bx na primeira linha.  

Vou continuar a fazendo uns exemplos aqui, vc pode pular pro próximo, se quiser.  

***mov ax,[bx]**; que pega o que tem no endereço correspondente ao número BX, e não o valor contido em bx e joga pra ax.  

mov,d=1,w=1 -> 1000'1011 = 0x8b.  
mod,reg,r/m -> 0000'0111 = 0x07.  
-ucs:0100  

### Eu não vou fazer alguns exercícios da parte prática

Tem uns que ele falou que não era pra fazer mesmo, então to nem aí, fi.

### mov ax,[1000]

bora testar

vou ROUBAR aqui... Vou fazer engenharia reversa da parada  

1) Primeiro eu vou fazer 'acs:0100' e escrever 'mov ax,[1000]'
2) Depois eu vou rodar um 'r' para ver o q tá escrito na linha do cs:0100
3) vejo que está escrito "A1 00 10"
4) olho no datasheet algo que bate com isso. Eu percebi que estamos lidando agora em pegar informação direto da memória (endereço 1000) e jogando para o registrador de acumulação (ax, no caso)
5) Se vc reparar em *"Memory to Accumulator"*, vai ver que agora são 3 bytes que você tem que escrever.
6) O primeiro é o opcode ainda, 1010'0001 (também conhecido como A1, W = 1 pois estamos lidando com words)
7) O segundo byte é o addr-low, referente ao endereço da memória em que você quer pegar (q é os dois ultimos bits do endereço que vc pegar, no caso **00** de 10**00**)
8) O terceiro byte é o addr-high (mesmo esquema acima, mas **10** de **10**00)  

Para você ver o efeito disso, troque o 'mov ax,[1000]' para 'mov ax,[1234]' e veja os efeitos.  

mov ax,bx -> registrador/memória to/from registrador  
mov ax,1000 -> valor constante (imediato) para registrador
mov ax,[1000] -> um valor na memória para jogar no registrador de acumulação  
