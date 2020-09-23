# Segmentos de memória

**(A formatação está uma porcaria, quem quiser ajudar, mande um pull request).**  
São macetes que a Intel utilizou para poder mapear a memória de 20bits usando registradores de 16bits.
Um segmento de memória é nada mais nada menos do que um "offset" (parágrafo, eu acho) para poder usar 16 bits para conseguir endereçar todos as células dos registradores

## Tipos de segmentos de memória

* CS = Code segment
* DS = Data segment
* ES = Extra segment
* SS = Stack segment  

Cada um deles tem um valor em específico, que nem mostrado no início das aulas. O meu CS, por exemplo é 0x0760, em alguns casos é 0x075F

### Observações

A notação: ds:<número qualquer> indica que você está operando em um endereço de memória que começa em DS e tem um offset de <número qualquer>  
A notação em colchetes indica que você está acessando o VALOR contido dentro daquele endereço de memória (usualmente para dados)

## Lista de comandos

### Comando para registradores (R = register)

* -r : Comando para ver os registradores
* -r<reg> : comando para ver e alterar o valor dos registradores
* ex: -rax -> vê o valor e altera de AX; -rcs -> vê o valor e altera de CS
* -rf : mostra a lista de flags (interrupções, como OF = overflow) **(Não vou focar nisso)**

### Comando para posições de memória (D = dump)

* d : mostra todos os valores. O padrão inicial é de 128 bytes
* d<segmento>:<offset inicial>,<offset final> : Vê os valores de memória nas posições especificadas.
* ex: dds:0100 -> Vê no segmento DS, o segmento DS
* dds:0000,0 -> Vai mostrar o primeiro valor de memória armazenado em ds:0000
* dds:0000,1 -> Vai mostrar os dois primeiros valores de memória armazenado em ds:0000

## Comando para verificar/alterar conteúdos de uma posição de memória (E = Exchange (eu acho))

* -e<segmento>:<offset inicial>  
ex: -eds:0000 -> Informa o valor em DS:0000 e pede para você alterar.
* eds:0000,aabc -> já altera direto o valor daquele cara

## Comando para montar (assemblar) código (A = assembly)

* -a<endereço> (por padrão é o CS:IP)
Serve para você ir escrevendo o código nos endereços reservados para código (CS).  
ex: -a  
mov ax, 1000  
mov bx, 2000  
mov ax, cx  
add ax, bx  

## Comando para "desassemblar" (unassembly)

* -u<segmento>:<offset inicial>,<offset fim>
Ele vai na memória consultar o que está escrito e transforma em código. Por padrão, ele vai consultar o CS
ex: -u  
(inserir imagem)

## Comando para executar o código

-t<endereço>,<offset>
Se vc executar só "-t", ele vai executar e vai mostrar os valores e a próxima linha de código.

## mov

mov ax, 1000  
pega o valor 0x1000 e salva em ax  
mov ax, [1000]  
pega o valor DS:1000 e salva em ax (eu acho).  
