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

	;;;;;;;;;;;;;; 1 posição ;;;;;;;;;;;;;;;;

	; Imprimir a msg na tela (digite um numero)
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,msg 	;mensagem 
	mov edx,msg_L	;qtd de caracteres
	int 0x80	;executa 


	; Ler o numero digitado na variavel "num" 
	mov eax,3	 ;syscall read
	mov ebx,0	 ;fd
	mov ecx,num	 ;variavel
	mov edx,2	 ;qtd, sempre em bytes
	int 0x80
	
	mov eax,[num]	;eax recebe o valor digitado
	mov [matriz+0],eax	;matriz na posição adequada recebe o valor digitado

	;;;;;;;;;;;;;; 2 posição ;;;;;;;;;;;;;;;;;;;

	; Imprimir a msg na tela (digite um numero)
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,msg 	;mensagem 
	mov edx,msg_L	;qtd de caracteres
	int 0x80	;executa 


	; Ler o numero digitado na variavel "num" 
	mov eax,3	 ;syscall read
	mov ebx,0	 ;fd
	mov ecx,num	 ;variavel
	mov edx,2	 ;qtd, sempre em bytes
	int 0x80
	
	mov eax,[num]	;eax recebe o valor digitado
	mov [matriz+2],eax	;matriz na posição adequada recebe o valor digitado
	
	;;;;;;;;;;;;;; 3 posição ;;;;;;;;;;;;;;;;;;;

	; Imprimir a msg na tela (digite um numero)
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,msg 	;mensagem 
	mov edx,msg_L	;qtd de caracteres
	int 0x80	;executa 


	; Ler o numero digitado na variavel "num" 
	mov eax,3	 ;syscall read
	mov ebx,0	 ;fd
	mov ecx,num	 ;variavel
	mov edx,2	 ;qtd, sempre em bytes
	int 0x80
	
	mov eax,[num]	;eax recebe o valor digitado
	mov [matriz+4],eax	;matriz na posição adequada recebe o valor digitado

	;;;;;;;;;;;;;; 4 posição ;;;;;;;;;;;;;;;;;;;

	; Imprimir a msg na tela (digite um numero)
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,msg 	;mensagem 
	mov edx,msg_L	;qtd de caracteres
	int 0x80	;executa 


	; Ler o numero digitado na variavel "num" 
	mov eax,3	 ;syscall read
	mov ebx,0	 ;fd
	mov ecx,num	 ;variavel
	mov edx,2	 ;qtd, sempre em bytes
	int 0x80
	
	mov eax,[num]	;eax recebe o valor digitado
	mov [matriz+6],eax	;matriz na posição adequada recebe o valor digitado


	;;;;;;;;;;;;;; 5 posição ;;;;;;;;;;;;;;;;;;;

	; Imprimir a msg na tela (digite um numero)
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,msg 	;mensagem 
	mov edx,msg_L	;qtd de caracteres
	int 0x80	;executa 


	; Ler o numero digitado na variavel "num" 
	mov eax,3	 ;syscall read
	mov ebx,0	 ;fd
	mov ecx,num	 ;variavel
	mov edx,2	 ;qtd, sempre em bytes
	int 0x80
	
	mov eax,[num]	;eax recebe o valor digitado
	mov [matriz+8],eax	;matriz na posição adequada recebe o valor digitado


	;;;;;;;;;;;;;; 6 posição ;;;;;;;;;;;;;;;;;;;

	; Imprimir a msg na tela (digite um numero)
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,msg 	;mensagem 
	mov edx,msg_L	;qtd de caracteres
	int 0x80	;executa 


	; Ler o numero digitado na variavel "num" 
	mov eax,3	 ;syscall read
	mov ebx,0	 ;fd
	mov ecx,num	 ;variavel
	mov edx,2	 ;qtd, sempre em bytes
	int 0x80
	
	mov eax,[num]	;eax recebe o valor digitado
	mov [matriz+10],eax	;matriz na posição adequada recebe o valor digitado

	;;;;;;;;;;;;;; 7 posição ;;;;;;;;;;;;;;;;;;;

	; Imprimir a msg na tela (digite um numero)
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,msg 	;mensagem 
	mov edx,msg_L	;qtd de caracteres
	int 0x80	;executa 


	; Ler o numero digitado na variavel "num" 
	mov eax,3	 ;syscall read
	mov ebx,0	 ;fd
	mov ecx,num	 ;variavel
	mov edx,2	 ;qtd, sempre em bytes
	int 0x80
	
	mov eax,[num]	;eax recebe o valor digitado
	mov [matriz+12],eax	;matriz na posição adequada recebe o valor digitado

	;;;;;;;;;;;;;; 8 posição ;;;;;;;;;;;;;;;;;;;

	; Imprimir a msg na tela (digite um numero)
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,msg 	;mensagem 
	mov edx,msg_L	;qtd de caracteres
	int 0x80	;executa 


	; Ler o numero digitado na variavel "num" 
	mov eax,3	 ;syscall read
	mov ebx,0	 ;fd
	mov ecx,num	 ;variavel
	mov edx,2	 ;qtd, sempre em bytes
	int 0x80
	
	mov eax,[num]	;eax recebe o valor digitado
	mov [matriz+14],eax	;matriz na posição adequada recebe o valor digitado

	;;;;;;;;;;;;;; 9 posição ;;;;;;;;;;;;;;;;;;;

	; Imprimir a msg na tela (digite um numero)
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,msg 	;mensagem 
	mov edx,msg_L	;qtd de caracteres
	int 0x80	;executa 


	; Ler o numero digitado na variavel "num" 
	mov eax,3	 ;syscall read
	mov ebx,0	 ;fd
	mov ecx,num	 ;variavel
	mov edx,2	 ;qtd, sempre em bytes
	int 0x80
	
	mov eax,[num]	;eax recebe o valor digitado
	mov [matriz+16],eax	;matriz na posição adequada recebe o valor digitado


	;;;;;;;; 1 coluna da matriz ;;;;;;;;;




	; Imprimir na msg na tela (1 coluna)
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,msg2 	;mensagem (msg)
	mov edx,msg2_L	;qtd de caracteres (msg_L)
	int 0x80	;executa 

	;;;;;;;;; Imprimir os valores da 1 coluna


	;;;;;;;;; matriz[0][0]	

	; Imprimir cada valor da primeira coluna
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,matriz+0 	;mensagem (msg)
	mov edx,2	;qtd de caracteres (msg_L)
	int 0x80	;executa  

	;;;;;;;;; matriz[0][1]	

	; Imprimir cada valor da primeira coluna
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,matriz+6	;mensagem (msg)
	mov edx,2	;qtd de caracteres (msg_L)
	int 0x80	;executa  

	;;;;;;;;; matriz[0][3]	

	; Imprimir cada valor da primeira coluna
	mov eax,4	;syscall write
	mov ebx,1	;fd(1 = tela)
	mov ecx,matriz+12 	;mensagem (msg)
	mov edx,2	;qtd de caracteres (msg_L)
	int 0x80	;executa  



	mov eax,1 ;sair
	mov ebx,0
	int 0x80


