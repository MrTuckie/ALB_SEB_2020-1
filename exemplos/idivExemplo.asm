; https://www.geeksforgeeks.org/assembly-language-program-8086-microprocessor-divide-16-bit-number-8-bit-number/
; http://www.c-jump.com/CIS77/MLabs/M11arithmetic/index.html

;Feito por Arthur Lorencini Bergamaschi
; Vamos fazer a divisão simples usando a instrução idiv, divisão considerando o sinal.
; Vamos dividr ax por bl (16 bits divididos por um número de 8 bits) e obter o Quociente em al e o Resto em AH.
; A divisão é sempre feita com o dividendo em AX, o divisor fica em qualquer outro.
; Recomenda-se que este código seja utilizado com o "debug divExemplo.exe" e usando o comando "t"
; para executar as ações
; Você pode ir acompanhando as mudanças nos valores dos registradores
; Este código ainda não printa nada na saída
segment code ; início do código
..start:
	mov ax,data 
	mov ds,ax 
	mov ax,stack 
	mov ss,ax 
	mov sp,stacktop 
;
    xor ax, ax ; ao fazer isso, você garante que ax = 0000'0000 = 0x0000
    mov bl, -3 ; bl = 0x00fd (eu acho que isto está errado)
    mov ax, 16 ; ax = 0x0010
    idiv bl    ; al = ax/bl , ah = ax%bl, ou seja al = 16/-3 =-5=0xFB e ah=ax%bl=1=0x01, ax=0x01fb
FIM:
	mov ah,4ch 
	int 21h 
segment data
segment stack stack ; não precisa se preocupar com isso
	resb 256 
	
stacktop: ; 