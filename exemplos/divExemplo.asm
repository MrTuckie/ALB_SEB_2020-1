; https://www.geeksforgeeks.org/assembly-language-program-8086-microprocessor-divide-16-bit-number-8-bit-number/
; Feito por Arthur Lorencini Bergamaschi
; Vamos fazer a divisão simples usando a instrução div
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
    mov bx, 3 ; bx = 0x0003
    mov ax, 16 ; ax = 0x0010
    div bl    ; al = ax/bl , ah = ax%bl, ou seja al = 16/3 = 5 e ah=ax%bl=1
 FIM:
	mov ah,4ch 
	int 21h 
segment data
segment stack stack ; não precisa se preocupar com isso
	resb 256 
	
stacktop: ; 