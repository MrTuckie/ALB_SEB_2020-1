# lab-03 de embarcados

Para quem não entende muito de Compiladores em geral (que nem eu): https://www.tutorialspoint.com/compiler_design/compiler_design_overview.htm

Links: https://en.wikipedia.org/wiki/Assembly_language
https://en.wikipedia.org/wiki/Object_code
https://en.wikipedia.org/wiki/Linker_(computing)
https://www.tutorialspoint.com/assembly_programming/assembly_introduction.htm

https://www.youtube.com/watch?v=Z5JC9Ve1sfI

## Conteúdos:
1)	Fazendo um "hello world" (nesse caso, um "oi") em assembly
2)	Compilar e linkar um código em .asm 
3)	Entender o papel do NASM16 e do Freelink

### Entendo o fluxo

1) o código escrito em um arquivo ".asm" vai ser assemblado pelo, no caso, o nasm e vão sair dois arquivos: .obj e .lst
2) O código assemblado (.obj e .lst) vai ser linkado pelo linker, no caso, freelink e vai resultar em um arquivo .exe (que é executável pelo dosBox)

### Nasm (ou Nasm16)

O que é o "nasm":

* This is the project webpage for the Netwide Assembler (NASM), an asssembler for the x86 CPU architecture portable to nearly every modern platform, and with code generation for many platforms old and new.

### Freelink

O que é o "freelink":

* FreeLink is a FREE enhanced object linker for MS-DOS using WarpLink technology.
* Ele serve para "linkar os objetos" (arquivos obj) e transformar em .exe (ou .dll, depende do caso)

## Como montar o código

Na linha de comando:

1) nasm (ou nasm16) <nome_do_arquivo>.asm -f obj -o <nome_do_arquivo>.obj -l <nome_do_arquivo>.lst <nome_do_arquivo>.asm
2) freelink <nome_do_arquivo> (não tem .lst e nem .obj mesmo)
3) <nome_do_arquivo> (rodando o programa)

Existe algum macro usando "%1" que compila, ainda estou pesquisando isso.
**nasm16 -f obj -o %1.obj -l %1.lst <nome_do_arquivo>.asm**

## Lista de macetes para só copiar e colar

1) nasm16 -f obj -o <nome_do_arquivo>.obj -l <nome_do_arquivo>.lst <nome_do_arquivo>.asm
