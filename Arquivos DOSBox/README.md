# Arquivos para o DOSBox

## Pontos importantes

Seu dosbox tem que estar devidamente configurado. As variáveis de ambiente (conhecidas como 'PATH') determinam se você vai conseguir chamar o "NASM" e o "FREELINK" pela linha de comando em qualquer diretório que você esteja no DOSBOX. **Como assim, arthur lindo?** Lembra que lá em PBC, vc chamava o "gcc" de qualquer lugar da pasta? O mesmo vale aqui também. Lá já vem configurado no sistema operacional. Já aqui, precisamos configurar pelo o arquivo ".conf" na mão.

### helloWorldAssembly

Aqui ficam alguns arquivos para fazer o "hello world" em assembly. No arquivo ".asm" tem a o código que é assemblado e linkado e depois executado. Esse código está cheio de comentários.

### dosbox-074-3.conf

Este arquivo é importante para você não ter que ficar digitando tudo na mão e ter certeza que as suas variáveis de ambiente (PATH) estão configuradas corretamente.

Esse arquivo .conf serve para automatizar algumas rotinas utilizadas no DOSBox 0.74.
As rotinas são colocadas no final do arquivo. Você pode ler a documentação também na página oficial deles: [https://www.dosbox.com/wiki/]

No linux, você muda na pasta /home/user/.dosbox

No windows, eu não instalei, mas quem quiser, dá um pull request e configura.
Provavelmente deve ser na pasta de "Program files (x86)". "C:\Program Files (x86)\DosBOX" (eu acho!!)
