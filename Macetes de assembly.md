# Macetes simples

Use o editor de sua preferência, que vai ser o VSCode, da microsoft e instale: 
[https://marketplace.visualstudio.com/items?itemName=13xforever.language-x86-64-assembly]  
Cheatsheet
[https://www.cs.uaf.edu/2005/fall/cs301/support/x86/nasm.html]

; -> Comentários
mov destino, fonte
segment code
segment data
segment code

Estrutura do código
[label]   mnemonic   [operands]   [;comment]

Registradores: [https://github.com/gurugio/book_assembly_8086/blob/master/8086arch.md]  
Stacks: [https://www.youtube.com/watch?v=d-2Peb3pCBg]

8086 processor has 8 general registers.

* AX: called as **accumulation** register or called as arithmetic register. It is mainly used for calculations.
* BX: This is called as **base address** register. It is mainly used when calculating memory addresses.
* CX: This is called as **counter register**. It is mainly used to remember how many times you are repeating in the loop.
* DX: **Data** register. The result of the calculation is stored or the data read from memory is saved.
* SI: This is called as **source index** register. Used to store the address of the original data in memory copying.
* DI: This is called the **destination index** register. It is used to store the address of destination in memory copy etc.
* BP: **Base Pointer** Register. Used to preserve stack addresses when calling function.
* SP: **Stack Pointer** Register. The current stack address is saved.

interrupções:
https://en.wikipedia.org/wiki/INT_(x86_instruction)
As is customary with machine binary arithmetic, interrupt numbers are often written in hexadecimal form, which can be indicated with a prefix 0x or with the suffix h. For example, INT 13H will generate the 20th software interrupt (0x13 is the number 19 -- nineteen -- written in hexadecimal notation, and the count starts with 0), causing the function pointed to by the 20th vector in the interrupt table to be executed, which is typically a DOS API call. 
https://en.wikipedia.org/wiki/DOS_API

push	Push word onto stack
  Syntax:	push	op16
  op16: 16-bit register or memory
  Action: Push op16 onto the stack (i.e., SP = SP - 2 then [SS:SP] = op16).
  Flags Affected: None
  Notes: Pushing and popping of SS and SP are allowed but strongly discouraged.