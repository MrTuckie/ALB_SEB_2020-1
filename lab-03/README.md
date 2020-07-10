# lab-03 de embarcados

## Conteúdos:
1)	Fazendo um "hello world" (nesse caso, um "oi") em assembly
2)	Compilar e linkar um código em .asm 
3)	Entender o papel do NASM16 e do Freelink

### Nasm (ou Nasm16)


### Freelink

## Como montar o código:
1) nasm <nome_do_arquivo>.asm ou nasm16 -f obj -o <nome_do_arquivo>.obj -l <nome_do_arquivo>.lst <nome_do_arquivo>.asm
2) freelink <nome_do_arquivo>
3) <nome_do_arquivo> (rodando o programa)



Existe algum macro usando "%1" que compila, ainda estou pesquisando isso.
** nasm16 -f obj -o %1.obj -l %1.lst %1.asm **
## Lista de macetes para só copiar e colar:
1) nasm16 -f obj -o <nome_do_arquivo>.obj -l <nome_do_arquivo>.lst <nome_do_arquivo>.asm

