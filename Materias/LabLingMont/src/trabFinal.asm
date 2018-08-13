;;;;;;;;;;;;;;;;; Trabalho final de Lab de Montagem ;;;;;;;;;;;;;;;;;;;;;;;
;;; 		     Rafael Stefanini Carreira				;;;
;;;			   Bruno Maciel					;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%macro print 3	;; função de impressão
	mov eax,4	;;syscall write
	mov ebx,%3	;;file descriptor
	mov ecx,%1	;;variavel (conteudo)
	mov edx,%2	;;tamanho
	int 0x80	;;interrupção
%endmacro

%macro scanf 3  ;; função de leitura
	mov eax,3   ;;syscall read
	mov ebx,%3  ;;file descriptor
	mov ecx,%1  ;;ponteiro para o destino
	mov edx,%2  ;;tamanho
	int 0x80   ;;interrupção
%endmacro

;;strings utilizadas no trabalho
section .data 
	;;;msg de erro nos parametros
	erroPar1:	db	"Erro: Arquivo não informado",0ah,"Uso: "
	erroPar1_L:	equ	$-erroPar1
	erroPar2:	db	" arquivo.txt",0ah
	erroPar2_L:	equ	$-erroPar2
	;;erro na hora de salvar, ou nao, na hora de sair
	erroS:		db	"Digite 's' ou 'n' : "
	erroS_L:	equ	$-erroS
	;;msg contar palavras
	msg:		db	"O número de palavras é: "
	msg_L:		equ	$-msg
	;;msg ao sair
	msg2:		db	"Deseja salvar antes de sair [s/n]:  "
	msg2_L:		equ	$-msg2 
	;;comandos utilizados durante a edição do arquivo
	salvar:		db	"slvr",0xa	;; comando salvar
	contarp:	db	"cpal",0xa	;; comando contar palavras 
	sair:		db	"sair",0xa	;; comando sair

;;variaveis utilizadas no programa
section .bss
	id:		resd	1	;;identificador do arquivo de entrada
	nome_arq:	resb	50	;;nome do arquivo de entrada informado pelo usuário
	nomeProg:	resb	50	;;nome do programa
	buffer:		resb 	1000	;;variavel que armazena o conteudo temporario
	info:		resb	1	;;variavel que armazena cada caractere lido
	comando:	resb	5	;;variavel que recebe o comando
	bufferCont:	resb	100	;;buffer para contar as palavras
	num:		resb    5	;;num de palavras

section .text
	global _start:

_start:
	pop eax		;;pega o numero de parametros
	cmp eax,1	;;compara quantidade de parametros com 1 
	jng .exitErr 	;;sair com erro nas parametros se não for maior que 1

	call .nomeArquivo ;;coloca o nome informado por parametro na variavel "nome_arq"
	
	call .abrirArquivo ;;abri o arquivo, se não existir, cria. coloca id em "id"
	
	call .conteudo	;;ler e escrever o conteudo do arquivo na tela

	jmp .editar	;;ler e interpretar o que o usuario escrever


;;;;;;;;;;;;;; Ler o que for digitado, interpretar os comandos e salvar se lotar o buffer ;;;;;;;

.editar 	mov ebx,0	;;zera o contador do buffer
.ler		push ebx	;;salva o valor do contador
		scanf info,1,0	;;le um byte do terminal
		pop ebx 	;;retorna o valor anterior
		mov al,[info]	;;coloca o caractere em al

		;;interpretar comandos
		cmp al, byte '/' ;;compara o caractere com '/'
		jne .continua ;;se não for, continua
	
		jmp .comando	;;se for, vai para interpretar comandos

.continua	mov [buffer+ebx],al	;;coloca o caractere no buffer
		inc ebx			;;incrementa a posição

		;;verificar se chegou no limite da variavel
		cmp ebx,1000	;;compara com o tamanho maximo do buffer
		jge .salva 	;;se for maior  ou igual, salva o conteudo

		jmp .ler	;;volta a ler 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;; Interpreta os comandos digitados ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


.comando	push ebx	;;guarda ebx
		scanf comando,5,0	;;le 4 bytes do terminal (referente ao possivel comando)
		pop ebx		;;retorna ebx

		mov eax,[salvar]	;;eax recebe o comando de salvar
		sub eax,[comando]	;;subtrai o comando digitado de eax
		cmp eax,0		;;se forem iguais, eax=0
		je .salva		;;então salva

		mov eax,[contarp]	;;eax recebe o comando de contar palavras
		sub eax,[comando]	;;subtrai o comando digitado de eax
		cmp eax,0		;;se forem iguais, eax=0
		je .contar		;;então conta as palavras

		mov eax,[sair]		;;eax recebe o comando de sair
		sub eax,[comando]	;;subtrai o comando digitado de eax
		cmp eax,0		;;se forem iguais, eax=0
		je .exitPerg		;;então sai do programa (com pergunta)

		;;;;;;;;;;;;;;;;; Se não for igual aos comandos, então é texto normal ;;;;;;;;;;;;;
			
		cmp ebx,994	;;verifica se há espaço para armazenar
		jl .temEspaco	;;se tiver, não precisa salvar

		;;se não tiver, salva o buffer no arquivo
		mov edx,ebx	;;coloca a quantidade de bytes em edx		
		print buffer,edx,[id]	;; imprime edx caracteres do buffer no arquivo
		mov ebx,0	;;zera o contador

.temEspaco	mov edx,0	;;contador da variavel "comando"
		mov al, byte '/'	;;primeiramente coloca o char "/" no buffer 
		mov [buffer+ebx],al
		inc ebx

.rep2		mov al,[comando+edx]	;;coloca o conteudo da variavel "comando" no buffer
		mov [buffer+ebx],al
		inc ebx
		inc edx

		cmp edx,4	;;verifica se ja colocou 3 caracteres
		jl .rep2

		mov al,[comando+edx]	;;se ja colocou, deixa o ultimo caractere em al
		jmp .continua	;;continua com a inserção de al no buffer e a leitura


;;;;;;;;;;;;;;;;; Conta o numero de palavras e imprime na tela ;;;;;;;;;;;;;;;;;;;;;

.contar		push ebx	;;salva ebx (posição no buffer)

		;;;;; posiciona o cursor no inicio do arquivo ;;;;;

		mov eax,140	;;syscall lseek
		mov ebx,[id]	;;fd do arquivo
		mov ecx,0	;;offset
		mov edx,0	;;do inicio
		int 0x80	;;chamada
	
		mov ecx,0	;;contador de palavras

.leMais		push ecx
		scanf bufferCont,100,[id]   ;;le 100 bytes do arquivo e coloca no buffer
		pop ecx

		cmp eax,0	;;verifica se leu algum byte
		je .converte	;;se não leu, não precisa nem contar

		mov ebx,0	;;contador na string lida

.repete		push eax ;;salva a qtd de bytes lidos	
		mov al, [bufferCont+ebx]  ;;guarda em al a posição da string determinada pelo contador ebx
		cmp al,' '	          ;;compara o caractere em al com ' ' (espaço)
		je .eh		          ;; for ' ' (espaço) verifica o proximo caractere
		cmp al, byte 0xa	  ;;compara com "\n" (quebra de linha)
		je .eh 			  ;; for "\n" (quebra de linha) verifica o proximo caractere
		;; se não é espaço ou quebra, não incrementa
		jmp .naoEh

.eh		mov al, [bufferCont+ebx+1]	;;verifica o proximo caractere
		cmp al,' '	;;se for espaço
		je .naoEh 	;;não incrementa
		
		cmp al, byte 0xa	;;se for quebra
		je .naoEh 	;;tambem não incrementa
		
		inc ecx		;;se for espaço ou quebra sequido de outro caractere, incrementa

.naoEh		inc ebx		;;incrementa o contador
		pop eax		;;quantidade de bytes lidos
		cmp ebx,eax	;;verifica se a string chegou ao final
		jne .repete	;;se nao chegou ao fim, verifica proximo caractere

		cmp eax,100	;;verifica por EOF
		jnl .leMais	;;não for, cintinua lendo e contando


		;; a quantidade de palavras está em ecx
.converte	mov eax,ecx     ;;coloca o num de palavras em eax
		;;;;converter o num de caracteres para ASCII
		mov ecx,10	;;divisor
		mov ebx,0	;;zera o contador
		
.toChar         mov edx,0       ;;zera edx (o valor só esta em eax)
                div ecx         ;;divide eax por ecx(10)
                                ;;o resto fica em edx
                add dl,"0"      ;;transforma em charactere
                mov [num+ebx],dl        ;;salva em "num", na posição correspondente (ebx)
                inc ebx         ;; cont++ (para salvar na proxima posição de "num")
                cmp eax,0       ;;verifica se o quociente ja chegou a zero
                jne .toChar     ;; senão continua o processo

		;;ao final do processo o valor (em ascii) estará em "num" na ordem inversa

		push ebx        ;;empilha o valor de ebx(quantidade de caracteres a serem imprimidos)

		print msg, msg_L, 1  ;;imprime msg "O numero de palavras é:"

        	pop ebx         ;;ebx recebe o primeiro valor da pilha (valor anterior de ebx)
.print  	dec ebx         ;;ajusta posição da string a ser imprimida

        	mov eax,[num+ebx]       ;;eax recebe o caractere a ser imprimido
        	mov [info],eax           ;;coloca em info o valor de eax

        	push ebx                ;;salva o valor de ebx
		print info,1,1 ;;imprimir o valor em info

        	pop ebx         ;;retorna o valor do contador em ebx
        	cmp ebx,0       ;;verifica se ja chegou a 0
        	jne .print      ;;senão chegou, continua imprimindo (na ordem inversa)

		mov [info], byte 0xa  ;;coloca uma quebra de linha em info
		print info,1,1	  ;; e imprime na tela (formatação)

		;;;; terminou de imprimir a quantidade de palavras ;;;;;
		
		pop ebx	;;retorna a posição de entrada no buffer

		jmp .ler ;;volta a ler caracteres do terminal
						

;;;;;;;;;;;;;;;;;;; salva o conteudo da variavel buffer no arquivo ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.salva		mov edx,ebx	;;coloca a quantidade de bytes em edx		
		print buffer,edx,[id]	;; imprime edx caracteres do buffer no arquivo

		jmp .editar			
	
;;;;;;;;;imprime o conteudo do arquivo na tela ;;;;;;;;;;;;;;;;;;;;;

.conteudo	scanf buffer,1000,[id]	;;le 100 bytes do arquivo e coloca no buffer
		mov edx,eax 		;;coloca a quantidade de bytes lidos em edx
		print buffer,edx,1	;;escreve edx bytes na tela
		cmp edx,1000		;;compara com 1000
		je .conteudo 		;;se for igual, tem mais conteudo a ser lido  

		ret 	;;se for maior, EOF, retorna

;;;;;;;;;;;;;; Função que tenta abrir o arquivo ;;;;;;;;;;;;;;

.abrirArquivo	mov eax,5  	    ;;syscall open
		mov ebx,nome_arq    ;;nome do arquivo digitado	
		mov ecx,2	    ;;leitura e escrita
		mov edx,0644q	    ;;permições rw-r--r--
		int 0x80	;;chamada
		
		cmp eax,0	;;verifica se abriu com sucesso
		jg .arqOk	;;se não abriu, cria novo arquivo

		mov eax,8	;;syscall create
		mov ebx,nome_arq ;;nome do arquivo de saida
		mov ecx, 0644q  ;;permições rw-r--r--
		int 0x80	;chamada
	
.arqOk		mov [id],eax	;;salva id		
		ret ;;retorna

;;;;;;;;;;;;;;;;;;;; Função que salva o nome do arquivo passado por parametro na variavel "nome_arq" ;;;;;;

.nomeArquivo	pop ebx	;;salva endereço de retorno 
		pop ecx ;;remove o nome do programa
		pop ecx	 ;;eax contem o primeiro parametro (nome do arquivo)

		mov edx,-1	;;defini o contador 
.nArq		inc edx 	;;incrementa o contador (primeira execução edx = 0)
		mov al,[ecx+edx] 	;;vai colocando 1 byte do parametro
		mov [nome_arq+edx],al	;;no nome do arquivo
		cmp [ecx+edx], byte 0	;;até chegar no "\0"
		jne .nArq

		push ebx ;;volta endereço de retorno
		ret ;;retorna

;;;;;;;;;;;;;;;; Sai do programa, com erro nos parametros ;;;;;;;;;;

.exitErr	print erroPar1,erroPar1_L,0  ;;mostra mensagem de erro (parte 1)	
		pop eax 	;;pega o nome do programa
		mov [nomeProg],eax ;;coloca em uma variavel
		
		;;;;;;;; o processo a seguir equivale a um strlen ;;;;;;;;;
		mov edx,0 ;;zera edx	
.rep		inc edx ;;incrementa a cada caractere
		cmp [eax+edx], byte 0 ;;verifica com "\0"
		jne .rep ;;continua contando
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
		print [nomeProg],edx,0	;; imprime o nome do programa
		print erroPar2,erroPar2_L,0	;;mostra mensagem de erro (parte 2)
		jmp .exit ;;sair

;;;;;;;;;;;;;;;;  Sai do programa, perguntando se deseja salvar ;;;;;;;;;;;

.exitPerg	push ebx	;;salva a posição no buffer
		print msg2, msg2_L, 1	;;imprime msg perguntondo se quer salvar
.pergunta	scanf info, 1, 0	;;lê 1 byte do terminal
		mov eax,[info]	;;coloca o caractere em eax
		cmp al, byte 's'	;;se for 's'
		je .exitSave	;;vai para "sair e salvar"
		cmp al, byte 'n'	;;se for 'n'
		je .exitOk	;;vai para "sair apenas"

		scanf info, 1, 0 ;; le o "\n"
		print erroS,erroS_L, 1	;;mostra msg de erro para salvar "s ou n"
		jmp .pergunta


.exitSave	pop edx	;;num de bytes no buffer          
                print buffer,edx,[id]   ;; imprime edx caracteres do buffer no arquivo

		
.exitOk		mov eax,6	;;syscall close
		mov ebx,[id] ;;fechar o arquivo de saida
		int 0x80	;;chamada
		
		scanf info, 1, 0 ;; le o "\n"

;;;;;;;;;;;; Sai do programa ;;;;;;;;;;;;;;		
.exit		mov eax,1 	;;syscall exit
		mov ebx,0	;;sem erros 	
		int 0x80	;;chamada
		ret
