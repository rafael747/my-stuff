; Trabalho de Lab de Linguagens
; Bruno Maciel
; Rafael Stefanini Carreira


section .data
	intro:   db     "-------------- 1° Trabalho de Lab de Montagem  ---------------",0ah
	intro_L: equ    $-intro
	msg:	 db	"Digite um numero: "
	msg_L:	 equ	$-msg

	msg2: 	 db	0ah,"Conteudo da primeira coluna",0ah
	msg2_L:	 equ    $-msg2

section .bss
	num:	resw 	1	;reserva 2 bytes
	matriz: resw	9	;reserva 9 * word ( 18 bytes)

section .text 
	global _start:

_start:

	; Imprimir a intro na tela
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,intro 	;mensagem 
	mov edx,intro_L	;qtd de caracteres
	int 0x80	;executa 

	mov ebx,0	;posição a ser inserido na matriz
.ler	push ebx	;quarda o valor anterior


	; Imprimir na msg na tela
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,msg 	;mensagem 
	mov edx,msg_L	;qtd de caracteres
	int 0x80	;executa 


	; Ler o num digitado
	mov eax,3	 ;syscall read
	mov ebx,0	 ;fd
	mov ecx,num	 ;variavel
	mov edx,2	 ;qtd, sempre em bytes
	int 0x80
	
	pop ebx		;retorna o valor anterior (posição para armazenar na matriz)

	mov eax,[num]	;eax recebe o valor digitado
	mov [matriz+ebx],eax	;matrix na posição ebx recebe o valor digitado

	add ebx,2	;incrementa 2 à posição de inserção na matriz
	
	cmp ebx,18	;verifica se ja preencheu toda a matriz
	jne .ler	;se não, le novo numero


	; Imprimir na msg na tela
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,msg2 	;mensagem (msg)
	mov edx,msg2_L	;qtd de caracteres (msg_L)
	int 0x80	;executa 


	mov ebx,0	;posição para a leitura da primeira coluna da matriz

.mostrar mov eax,[matriz+ebx]	;salva o valor de cada primeira coluna em "num"
	 mov [num],eax

	 push ebx	;salva posição anterior

	; Imprimir cada valor da primeira coluna
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,num 	;mensagem (msg)
	mov edx,2	;qtd de caracteres (msg_L)
	int 0x80	;executa  

	pop ebx		;volta valor da posição

	add ebx,6	;soma 6, para o proximo valor

	cmp ebx,18	;se não imprimiu todos
	jne .mostrar	;imprime o proximo

	mov eax,1 ;sair
	mov ebx,0
	int 0x80

	
