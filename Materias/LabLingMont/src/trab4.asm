; 4 Trabalho de Lab de Linguagens
; Bruno Maciel
; Rafael Stefanini Carreira


%macro	puts	2   ;;macro pra imprimir valores
	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 0x80
%endmacro


%macro	scanf	2   ;;macro pra imprimir valores
	mov eax,3
	mov ebx,0
	mov ecx,%1
	mov edx,%2
	int 0x80
%endmacro



section .data
	intro:   db     "-------------- 4° Trabalho de Lab de Montagem  ---------------",0ah
	intro_L: equ    $-intro

	fim:   db     0ah,"------------------------------------------------------------",0ah
	fim_L: equ    $-fim

	msg1:	 db	"Digite os elementos da primeira matriz: ",0ah
	msg1_L:	 equ	$-msg1

	msg2:	 db	"Digite os elementos da segunda matriz: ",0ah
	msg2_L:	 equ	$-msg2

	msg3:	 db	"A matriz resultante da soma é: "
	msg3_L:	 equ	$-msg3

	nl:	db	0ah

	espaco:	db	"    " ;; espaços
	espaco_L: equ	$-espaco

section .bss	;declaração de variaveis
	A:	resb	36	;;matriz A
	B:	resb	36	;;matriz B
	C:	resb	36	;;matriz C  (matriz resultante)



	num:	resb	5	;;variavel que recebe os valores
	aux:	resb	1	;;variavel para auxiliar na impressão



section .text

	global _start:
_start:
	
	
	puts	intro,intro_L	;;mostra a intro
	
	puts	 msg1,msg1_L	;;imprime msg digite a primeira matriz
	call .recebeMatrizA		;;recebe os elementos das matrizes A e B"

	puts	 msg2,msg2_L	;;imprime msg digite a primeira matriz
	call .recebeMatrizB		;;recebe os elementos das matrizes A e B"

	puts	 msg3,msg3_L	;;imprime msg: Matriz resultante
	call .somaMatrizes	;;função que soma as matrizes e coloca em C e a imprime
	
	call .fim		;;fim do programa.



;;;;;;;;;;;;;;;;;;; função que recebe a Matriz A ;;;;;;;;;;;;;;;

.recebeMatrizA	mov ebx,0 		;;posição de inserção na matriz
.lerA		push ebx		;;guarda o valor anterior
		scanf num,4		;;le o valor a ser inserido
		call .toINT		;;chama função para converter para numero
		pop ebx	 		;;retorna o valor de ebx
		
		mov eax,[num]	;; guarda o valor na posição correspondente da matriz A
		mov [A+ebx],eax
		
		add ebx,4	;;incrementa ebx para a proxima posição
	
		cmp ebx,36	;;verifica se ja recebeu todos os valores
		jne .lerA	;;senão ler proximo numero
		
		puts nl,1	;;imprime uma quebra de linha
		ret ;;retorna

;;;;;;;;;;;;;;;;;;; função que recebe a Matriz B ;;;;;;;;;;;;;;;;;;;;;;;;;;

.recebeMatrizB	mov ebx,0 		;;posição de inserção na matriz
.lerB		push ebx		;;guarda o valor anterior
		scanf num,4		;;le o valor a ser inserido
		call .toINT		;;chama função para converter para numero
		pop ebx	 		;;retorna o valor de ebx
		
		mov eax,[num]	;; guarda o valor na posição correspondente da matriz B
		mov [B+ebx],eax
		
		add ebx,4	;;incrementa ebx para a proxima posição
	
		cmp ebx,36	;;verifica se ja recebeu todos os valores
		jne .lerB	;;senão ler proximo numero


		puts nl,1	;;imprime uma quebra de linha
		ret ;;retorna

;;;;;;;;;;;;;;;;;;;;;;; Função que somas as Matrizes e coloca em C ;;;;;;;;;;;;;;;;;;;

.somaMatrizes	puts nl,1	;;imprime uma quebra de linha
		mov ebx,0               ;;posição de adição das matrizes
		mov ecx,0		;;contador para quebrar linha

.soma           mov eax,[A+ebx]         ;;coloca o valor da matriz A em eax
		mov edx,[B+ebx]		;;coloca o valor da matriz B em edx
		add eax,edx			;;soma os valores
		mov [C+ebx],eax		;;coloca em C
		mov [num],eax	;;coloca em num para imprimir
		push ebx	;;guarda o valor de ebx
		
		cmp ecx,3	;;verifica se ja imprimiu 3 valores
		jne .naoQuebra	;;se não imprimiu, não quebra linha

		puts nl,1	;;se já, imprime uma quebra de linha
		mov ecx,0	;;e zera o contador de quebra
		
.naoQuebra	push ecx		;;salva o valor de ecx(contador de quebra de linha)

		call .toASCII		;;converte em char e imprime

		pop ecx		;;retorna o valor de ecx
		pop ebx		;;retorn o valor de ebx
		add ebx,4	;;vai para a proxima posição
		inc ecx		;;incrementa o contador de quebra de linha
		cmp ebx,36	;;verifica se ja somou todos os elementos
		jne .soma	;;senão, volta a somar
		ret
              

;;;;;;;;;;;;;;;;;; Função que converte "num" para inteiro ;;;;;;;;;;;;;;

.toINT  mov ecx,10  ;;multiplicador
	mov ebx,0   ;;contador
	mov eax,0   ;;valor resultante

.rep    mul ecx                 ;;multiplica o valor atual de eax por 10 
        mov dl,[num+ebx]        ;;coloca o proximo charactere em dl
        sub dl,"0"              ;;transforma em numero
        add eax,edx             ;;adiciona em eax
        inc ebx                 ;;cont++ (para pegar o proximo charactere)
        cmp [num+ebx],byte 10   ;;verifica se ja chegou ao final da string
        jne .rep
	mov [num],eax 		;;final: numero(int) em num
	ret



;;;;;;;;;;;;;; Converte o valor de "num" pra ascii e Imprime na tela ;;;;;;;;;;;;;;;;;;;;;

.toASCII	mov ecx,10	;;divisor
		mov ebx,0	;; zera o contador
		mov eax,[num]	;; coloca o valor a ser convertido em eax

.toCHAR 	mov edx,0	;;zera edx (o valor só esta em eax)
		div ecx		;;divide eax por ecx(10)
				;;o resto fica em edx
		add dl,"0"	;;transforma em charactere
		mov [num+ebx],dl	;;salva em "num", na posição correspondente (ebx)
		inc ebx		;; cont++ (para salvar na proxima posição de "num")
		cmp eax,0	;;verifica se o quociente ja chegou a zero
		jne .toCHAR	;; senão continua o processo
		
		
		;;ao final do processo o valor (em ascii) estará em "num" na ordem inversa


.print	dec ebx		;;ajusta posição da string a ser imprimida

	mov eax,[num+ebx] 	;;eax recebe o caractere a ser imprimido
	mov [aux],eax		;;coloca em aux o valor de eax
	
	push ebx		;;guarda o valor de ebx
	
	puts aux,1	;;imprimir o valor em num

	pop ebx		;;retorna o valor do contador em ebx
	cmp ebx,0	;;verifica se ja chegou a 0
	jne .print	;;senão chegou, continua imprimindo (na ordem inversa)
	
	puts espaco,espaco_L	;;imprime espaços (formatação) 
        ret	;;retorna
	
;;;;;;;;;;;;;;;; Função que imprime linha final e sai do programa ;;;;;;;;;;;;;;;;;;

.fim	mov eax,4       ;;imprimir msg (digite uma frase)
	mov ebx,1
	mov ecx,fim
	mov edx,fim_L
	int 0x80
               
	mov eax,1	;;sair
	mov ebx,0
	int 0x80
	ret
