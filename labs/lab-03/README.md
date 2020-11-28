# lab-03 de embarcados

Para quem não entende muito de Compiladores em geral (que nem eu): [https://www.tutorialspoint.com/compiler_design/compiler_design_overview.htm]  

## Links úteis

Assembly: [https://en.wikipedia.org/wiki/Assembly_language]  
Object code: [https://en.wikipedia.org/wiki/Object_code]  
Linker (linkador): [https://en.wikipedia.org/wiki/Linker_(computing)]  
Introdução a assembly:[https://www.tutorialspoint.com/assembly_programming/assembly_introduction.htm]  
The Fetch-Execute Cycle: What's Your Computer Actually Doing? :[https://www.youtube.com/watch?v=Z5JC9Ve1sfI]  
DOS INT 21h - DOS Functions Codes: [http://spike.scu.edu.au/~barry/interrupts.html]

## Conteúdos da aula

1) Fazendo um "hello world" (nesse caso, um "oi") em assembly
2) Compilar e linkar um código em .asm
3) Entender o papel do NASM16 e do Freelink
4) Rodar e entender novos códigos

### Entendo o fluxo

1) Escrever o hello world e compilar e executar.
2) o código escrito em um arquivo ".asm" vai ser assemblado pelo, no caso, o nasm e vão sair dois arquivos: .obj e .lst
3) O código assemblado (.obj e .lst) vai ser linkado pelo linker, no caso, freelink e vai resultar em um arquivo .exe (que é executável pelo dosBox)

#### Nasm (ou Nasm16)

O que é o "nasm", o "assemblador":

* This is the project webpage for the Netwide Assembler (NASM), an asssembler for the x86 CPU architecture portable to nearly every modern platform, and with code generation for many platforms old and new.

#### Freelink

O que é o "freelink", o "linkador":

* FreeLink is a FREE enhanced object linker for MS-DOS using WarpLink technology.
* Ele serve para "linkar os objetos" (arquivos obj) e transformar em .exe (ou .dll, depende do caso)

## Como montar o código no DOSBox

Na linha de comando:

1) nasm (ou nasm16) <nome_do_arquivo>.asm -f obj -o <nome_do_arquivo>.obj -l <nome_do_arquivo>.lst <nome_do_arquivo>.asm (assemblando o código .asm)
2) freelink <nome_do_arquivo> (não tem .lst e nem .obj mesmo) (linkando o programa)
3) <nome_do_arquivo> (rodando o programa)  

**Graças a deus já existe um macete. *SE* você configurou certo os caminhos, *então* você pode só colocar "nasm oi" que o DOSBox já vai rodar a primeira linha (nasm -f obj ...) sem precisar que você digite tudo.**  

Adicionei um macete a mais. Se você escrever "nasm2 oi" no terminal, ele já roda o nasm e o freelink de uma 
vez.  

Se você escrever "nasm3 oi" no terminal, ele já faz tudo. Já sai executando o código e foda-se.  
Se você escrever "nasm4 oi", ele roda o "debug oi.exe" no final.

## O código em si

**Regra geral:** Não pode adicionar coisas que vem da memória diretamente nos registradores de segmento de memória (DS,SS, etc). Você precisa jogar para AX primeiro e depois de ax para ds, ou ss.

'$' = /0 é o final da string análogo ao C.