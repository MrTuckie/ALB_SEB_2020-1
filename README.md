# ALB_SEB_2020-1
Aulas de sistema embarcados - UFES - 2020 - 1


## Configurando o ambiente de programação (DOSBox 0.74) no Linux (Xubuntu 18.02)

1) Baixe os arquivos de debug (debug.exe) no repositório e coloque em alguma pasta (/home/user/dosbox);
2) Depois baixe usando sudo apt-get install dosbox para baixar o dosbox;
3) Abra o dosbox;
4) Rode o comando no dosbox: "mount c /home/user/dosbox";
5) Escreva debug para rodar os comandos de debug;
6) Baixe o arquivo .conf do dosbox para facilitar sua vida;

## Configurando o ambiente de programação (DOSBox 0.74) no Windows 10
1) Acesse o site www.dosbox.com para baixar o executável e instalar.
2) Para facilidade, crie uma pasta na raiz do seu HD. Ficando por exemplo: c:\codigos. É nessa pasta que você colocará seus programas.
3) Baixe o arquivo debug.exe no repositório e copie para a pasta criada no passo anterior. Esse arquivo já é executável, não precisa fazer nada além de copiá-lo.
4) Baixe no repositório o arquivo Nasm&freelink e descompacte na pasta criada no passo 2.
5) Abra o dosbox;
6) Rode o comando no dosbox: mount c c:\codigos;
7) Para abrir a pasta montada digite: c:
8) Para automatizar os comandos 6 e 7, vá na pasta: \Users\{username}\AppData\Local\DOSBox\dosbox-74-3.conf e no final, em [autoexec], inclua as duas linhas de comando.


## Links úteis:
### 8086:
8086 IS: https://ece425web.groups.et.byu.net/stable/labs/8086InstructionSet.html
Seis coisas que você tem que saber sobre o 8086: https://ece425web.groups.et.byu.net/stable/labs/8086Assembly.html

### DOSBox:
Página oficial: https://www.dosbox.com/wiki/
Atalhos e macetes (como fazer): https://www.dosbox.com/wiki/Shortcuts_that_You_Run_in_DOSBox

## Lista de comandos 8086
https://ece425web.groups.et.byu.net/stable/labs/8086InstructionSet.html


###### Feito por Arthur Lorencini Bergamaschi e Lucas Profiro. Professor da matéria: Evandro Ottoni.
