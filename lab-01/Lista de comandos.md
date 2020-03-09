# Segmentos
CS = Code segment
DS = Data segment
ES = Extra segment
SS = Stack segment

# Lista de comandos


## Comando para registradores (R = register):
-r : Comando para ver os registradores
-r<reg> : comando para ver e alterar o valor dos registradores
ex: -rax -> vê o valor e altera de AX; -rcs -> vê o valor e altera de CS
-rf : mostra a lista de flags (interrupções, como OF = overflow) **(Não vou focar nisso)**

## Comando para posições de memória (D = dump):
d<segmento>:<offset inicial>,<offset final> : Vê os valores de memória nas posições especificadas.
ex: dds:0100 -> Vê no segmento DS, o segmento DS
