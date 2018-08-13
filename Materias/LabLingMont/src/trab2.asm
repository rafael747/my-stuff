; 2 Trabalho de Lab de Linguagens
; Bruno Maciel
; Rafael Stefanini Carreira


section .data
	intro:   db     "-------------- 2° Trabalho de Lab de Montagem  ---------------",0ah
	intro_L: equ    $-intro

	fim:   db     0ah,"------------------------------------------------------------",0ah
	fim_L: equ    $-fim

	msg:	 db	"Digite um numero natural (até 4 digitos): "
	msg_L:	 equ	$-msg

	msg2:	 db	"O número digitado é maior que 100!"
	msg2_L:	 equ	$-msg2

section .bss	;declaração de variaveis
	num:	resb	5	;;numero digitado pelo usuario
	resul:	resb	5	;;resultado do quadrado
	aux:	resb	4	;;aux, para o contador ebx
section .text

	global _start:
_start:

	mov eax,4	;;imprimir intro
	mov ebx,1
	mov ecx,intro
	mov edx,intro_L
	int 0x80

	mov eax,4	;;imprimir msg (digite um num)
	mov ebx,1
	mov ecx,msg
	mov edx,msg_L
	int 0x80

	mov eax,3	;;ler numero e colocar em "num"
	mov ebx,0
	mov ecx,num
	mov edx,5
	int 0x80

	;;;;;;; converter para numero

	mov edx,0	;;recebe cada caractere no processo
	mov ebx,0	;;contador
	mov eax,0	;;acumulador
	mov ecx,10	;;multiplicador

	;;converte pra num e deixa em eax

.toINT	mul ecx			;;multiplica o valor atual de eax por 10 
	mov dl,[num+ebx]	;;coloca o proximo charactere em dl
	sub dl,"0"		;;transforma em numero
	add eax,edx		;;adiciona em eax
	inc ebx			;;cont++ (para pegar o proximo charactere)
	cmp [num+ebx],byte 10	;;verifica se ja chegou ao final da string
	jne .toINT		;;se não chegou ainda, continua convertendo

	;; ao final, o valor numérico correspondente estará em eax

	cmp eax,100	;compara com 100
	jge .erro	;se for maior ou igual, vai para a label .erro
	

	mul eax		;;eax <- eax * eax
	
	mov ebx,0	;; zera o contador

.toCHAR mov edx,0	;;zera edx (o valor só esta em eax)
	div ecx		;;divide eax por ecx(10)
			;;o resto fica em edx
	add dl,"0"	;;transforma em charactere
	mov [resul+ebx],dl	;;salva em "resul", na posição correspondente (ebx)
	inc ebx		;; cont++ (para salvar na proxima posição de "resul")
	cmp eax,0	;;verifica se o quociente ja chegou a zero
	jne .toCHAR	;; senão continua o processo

	;; o valor ao quadrado esta em "resul" na ordem inversa

.print	dec ebx		;;ajusta posição da string a ser imprimida

	mov eax,[resul+ebx] 	;;eax recebe o charactere a ser imprimido
	mov [num],eax		;;e coloca em num
	
	mov [aux],ebx		;;eux recebe o valor de ebx (temp)

	
	mov eax,4	;;imprimir o valor em num 
	mov ebx,1
	mov ecx,num
	mov edx,1
	int 0x80

	mov ebx,[aux]	;;retorna o valor do contador em ebx
	cmp ebx,0	;;verifica se ja chegou a 0
	jne .print	;;senão chegou, continua imprimindo (na ordem inversa)


	jmp .fim	;;apos imprimir toda a string, encerra sem mostrar o erro

.erro	mov eax,4	;;imprimir msg de erro (se o num for maior ou igual a 100)
	mov ebx,1
	mov ecx,msg2
	mov edx,msg2_L
	int 0x80


.fim	mov eax,4	;;imprimir linha 
	mov ebx,1
	mov ecx,fim
	mov edx,fim_L
	int 0x80


	mov eax,1	;;fim
	mov ebx,0
	int 0x80

