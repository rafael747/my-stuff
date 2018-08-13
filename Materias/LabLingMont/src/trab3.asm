
; 3 Trabalho de Lab de Linguagens
; Bruno Maciel
; Rafael Stefanini Carreira


section .data
	intro:   db     "-------------- 3° Trabalho de Lab de Montagem  ---------------",0ah
	intro_L: equ    $-intro

	fim:   db     0ah,"------------------------------------------------------------",0ah
	fim_L: equ    $-fim

	msg:	 db	"Digite uma frase: "
	msg_L:	 equ	$-msg

	msg2:	 db	"O número de palavras é: "
	msg2_L:	 equ	$-msg2

section .bss	;declaração de variaveis
	string:	resb	200	;;string digitada
	num:	resb	5	;;numero de palavras
	aux:	resb	1	;;variavel para auxiliar na impressão

section .text

	global _start:
_start:

	call .intro		;;chamada da intro

	call .printPergunta	;;chamada da msg "Digite uma frase:"

	call .lerFrase		;;chamada para leitura da frase inserida

	call .contaPalavra  	;;chamada da funçao que conta qtdd de palavras da frase

	call .toASCII		;; função para converter de numero para ASCII
	
	call .printNum		;; imprime quantidade de palavras da frase
	
	call .fim		;;fim do programa.



;;;;;;;;;;;;;;;  Função que imprime a intro ;;;;;;;;;;;;;;;;;

.intro	mov eax,4	;;imprimir intro
	mov ebx,1
	mov ecx,intro
	mov edx,intro_L
	int 0x80
	ret


;;;;;;;;;;;;;;;;  Função que imprime a pergunta ;;;;;;;;;;;;;;;

.printPergunta	mov eax,4	;;imprimir msg (digite uma frase)
		mov ebx,1
		mov ecx,msg
		mov edx,msg_L
		int 0x80
		ret

;;;;;;;;;;;;;;; Função que le a frase do usuário e coloca em "string"  ;;;;;;;;;;;;;;;


.lerFrase	mov eax,3
		mov ebx,0
		mov ecx,string
		mov edx,200
		int 0x80
		ret

;;;;;;;;;;;;;; Função que conta as palavras e coloca em "num" ;;;;;;;;;;;;;

.contaPalavra 	mov ebx,0	;;contador
		mov ecx,1	;;acumulador para qtdd de palavras

.repete	mov al, [string+ebx]	;;guarda em al a posição da string determinada pelo contador ebx
	cmp al,' '		;;compara o caractere em al com ' ' (espaço)
	jne .naoEh		;;se não for ' ' (espaço) não incrementa
	inc ecx			;;se for, incrementa
.naoEh	inc ebx				;;incrementa o contador
	cmp [string+ebx], byte 0xa	;;verifica se a string chegou ao final ('\n')
	jne .repete			;;se nao chegou ao fim, volta ao inicio do processo ".repete"
	mov [string+ebx+1],byte 0x0	;;insere '\0' após o '\n'

	mov [num],ecx	;;guarda a qtdd de palavras em 'num' 
	ret	
;;;;;;;;;;;;;; Converte o valor de "num" pra ascii ;;;;;;;;;;;;;;;;;;;;;

.toASCII	mov ecx,10	;;divisor
		mov ebx,0	;; zera o contador
		mov eax,[num]	;; coloca o numero de palavras em eax

.toCHAR 	mov edx,0	;;zera edx (o valor só esta em eax)
		div ecx		;;divide eax por ecx(10)
				;;o resto fica em edx
		add dl,"0"	;;transforma em charactere
		mov [num+ebx],dl	;;salva em "num", na posição correspondente (ebx)
		inc ebx		;; cont++ (para salvar na proxima posição de "num")
		cmp eax,0	;;verifica se o quociente ja chegou a zero
		jne .toCHAR	;; senão continua o processo
		
		ret		;;ao final do processo o valor (em ascii) estará em "num" na ordem inversa



;;;;;;;;;;;;;;  Função que imprime o numero de palavras digitadas ;;;;;;;;;;;; 

.printNum	;;imprime "ebx" valores de "num" 
	
	push ebx	;;empilha o valor de ebx(quantidade de caracteres a serem imprimidos)

	mov eax,4       ;;imprime msg "O numero de palavras é:"
	mov ebx,1
	mov ecx,msg2
	mov edx,msg2_L
	int 0x80

               
	pop ebx		;;ebx recebe o primeiro valor da pilha (valor anterior de ebx)

.print	dec ebx		;;ajusta posição da string a ser imprimida

	mov eax,[num+ebx] 	;;eax recebe o caractere a ser imprimido
	mov [aux],eax		;;coloca em aux o valor de eax
	
	push ebx		;;ebx recebe o valor de ebx (temp)
	
	mov eax,4	;;imprimir o valor em num 
	mov ebx,1
	mov ecx,aux
	mov edx,1
	int 0x80

	pop ebx		;;retorna o valor do contador em ebx
	cmp ebx,0	;;verifica se ja chegou a 0
	jne .print	;;senão chegou, continua imprimindo (na ordem inversa)
        ret
	
;;;;;;;;;;;;;;;; Função que imprime linha final e sai do programa ;;;;;;;;;;;;;;;;;;

.fim	;;imprimir fim e exit

	mov eax,4       ;;imprimir msg (digite uma frase)
	mov ebx,1
	mov ecx,fim
	mov edx,fim_L
	int 0x80
               
	mov eax,1	;;sair
	mov ebx,0
	int 0x80
	ret
