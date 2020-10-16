# ALB_SEB_2020-1

Notas de aulas de sistema embarcados - UFES - 2020 - 1

## Arquivos

### Arquivos DOSBox

Contém todos os arquivos necessários (ou quase todos) para as aulas de laboratório e projetos.

### Material do AVA

Usei aquilo apenas como referência e para ficar mais fácil de olhar os arquivos

### lab-0n

Acho que eu peguei do ava também, não tem todos ainda, mas alguns já estão comentados ou quase completos.

### Macetes de assembly.md

São macetes que eu vou encontrando e adicionando ali para conferir. **Considere como uma cola**

## Configurando o ambiente de programação (DOSBox 0.74-3) no Linux (Xubuntu 18.02 ou superior)

1) Baixe os arquivos de debug (debug.exe) no repositório e coloque em alguma pasta (/home/user/dosbox);
2) Depois baixe usando sudo apt-get install dosbox para baixar o dosbox;
3) Abra o dosbox;
4) Rode o comando no dosbox: "mount c /home/user/dosbox";
5) Escreva debug para rodar os comandos de debug;
6) Esqueça tudo acima e baixe o arquivo .conf do dosbox para facilitar sua vida;

## Configurando o ambiente de programação (DOSBox 0.74) no Windows 10
1) Acesse o site www.dosbox.com para baixar o executável e instalar.
2) Para facilidade, crie uma pasta na raiz do seu HD. Ficando por exemplo: c:\codigos. É nessa pasta que você colocará seus programas.
3) Baixe o arquivo debug.exe no repositório e copie para a pasta criada no passo anterior. Esse arquivo já é executável, não precisa fazer nada além de copiá-lo.
4) Baixe no repositório o arquivo Nasm&freelink e descompacte na pasta criada no passo 2.
5) Abra o dosbox;
6) Rode o comando no dosbox: mount c c:\codigos;
7) Para abrir a pasta montada digite: c:
8) Para automatizar os comandos 6 e 7, vá na pasta: \Users\{username}\AppData\Local\DOSBox\dosbox-74-3.conf e no final, em [autoexec], inclua as duas linhas de comando.

## Links úteis

### 8086

8086 Instruction Set (Conjunto de instruções, **muito útil**): [https://ece425web.groups.et.byu.net/stable/labs/8086InstructionSet.html]  
Seis coisas que você tem que saber sobre o 8086: [https://ece425web.groups.et.byu.net/stable/labs/8086Assembly.html]  
Livro sobre o intel 8086: [https://github.com/gurugio/book_assembly_8086/blob/master/8086arch.md]  

### Sobre DOSBox

Página oficial: [https://www.dosbox.com/wiki/]  
Atalhos e macetes (como fazer): [https://www.dosbox.com/wiki/Shortcuts_that_You_Run_in_DOSBox]  

Feito por Arthur Lorencini Bergamaschi.
Professor da matéria: Evandro Ottoni.

### Sobre o NASM

Hello world:  
[https://www.nasm.us/doc/nasmdoc9.html]

### Sobre a linguagem Assembly

First Look at Assembly [https://www.youtube.com/watch?v=tn1DCZI9jDA]  
Como funcionam os loops em Assembly [https://www.youtube.com/watch?v=jS5vTJRfmnI]  
Como funcionam as funções em Assembly [https://www.youtube.com/watch?v=Pgmbac_ckfM]  

## Como montar o código no DOSBox

Na linha de comando:

1) nasm (ou nasm16) <nome_do_arquivo>.asm -f obj -o <nome_do_arquivo>.obj -l <nome_do_arquivo>.lst <nome_do_arquivo>.asm (assemblando o código .asm)
2) freelink <nome_do_arquivo> (não tem .lst e nem .obj mesmo) (linkando o programa)
3) <nome_do_arquivo> (rodando o programa)  

**Se você configurou certo os caminhos, *então* você pode só colocar "nasm oi" que o DOSBox já vai rodar a primeira linha (nasm -f obj ...) sem precisar que você digite tudo.**  

Adicionei um macete a mais. Se você escrever "nasm2 oi" no terminal, ele já roda o nasm e o freelink de uma 
vez.  

Se você escrever "nasm3 oi" no terminal, ele já faz tudo. Já sai executando o código e foda-se. 

