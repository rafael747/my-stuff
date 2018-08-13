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


section .data
	intro:   	db	"----- 5º Trabalho de Lab de Montagem --------",0ah
	intro_L:	equ	$-intro
	msg:		db	"Digite o nome do arquivo a ser copiado: "
	msg_L:		equ	$-msg
	apend:		db	"(copia)",0h

section .bss
	id_in:		resd	1	;;identificador do arquivo de entrada
	id_out:		resd	1	;;identificador do arquivo de saida
	nome_arq:	resb	30	;;nome do arquivo informado pelo usuário
	arq_out:	resb	50	;;nome do arquivo de saída
	info:		resb 	400	;;variavel que armazena o conteudo

section .text
	global _start:
_start:

	print intro, intro_L, 1	;;mostra intro na tela

	print msg,msg_L,1	;;mostra msg (digite nome arquivo...)

	scanf nome_arq,30,0	;;lê 30 bytes da entrada padrão (fd=0) e armazena em nome_arq
	
	call .nomeSaida		;;função que preenche a variavel com o nome do arquivo de saida

	call .lerArq		;;função que lê o conteudo do arquivo de entrada

	call .escreveArq 	;;função que escreve o conteudo lido no arquivo de saída

	call .exit		;;fim do programa



.nomeSaida	mov ebx,0	;;posição na string
		
.nome		mov dl,[nome_arq+ebx]	;;coloca um byte do nome digitado
		mov [arq_out+ebx],dl	;;no nome do arquivo de saida
		inc ebx			;;passa pro proximo byte
		cmp [nome_arq+ebx], byte '.'	;;enquanto não encontra "."
		jne .nome		;;continua copiando uma string na outra

		mov ecx,ebx		;;ao encontrar o ".", ecx recebe a posição na string
		push ebx		;;salva o valor de ebx (para depois copiar a extenção)
		mov ebx,0		;;ebx recebe 0, para começar a copiar o apendice

.apend		mov dl,[apend+ebx]	;;coloca um byte do apendice (copia)	
		mov [arq_out+ecx],dl	;;no nome do arquivo de saida
		inc ebx			;;proximo byte no apendice
		inc ecx			;;proximo byte no arquivo de saida
		cmp [apend+ebx], byte 0h	;;verifica se ja chegou no final do apendice
		jne .apend		;;senão chegou, continua copiando o apendice

		;;apos colocar o apendice, o nome do arquivo de saida deve receber a extenção
		
		pop ebx		;;retorna estado do ebx

.ext		mov dl,[nome_arq+ebx]	;;coloca a extenção do arquivo digitado (posição ebx)
		mov [arq_out+ecx],dl	;;no nome do arquivo de saida (posição ecx)
		inc ebx		;;incrementa posição em "nome_arq"
		inc ecx		;;incrementa posição em "arq_out"
		cmp [nome_arq+ebx], byte 0ah ;;verifica se chegou no final da string digitada
		jne .ext	;;se nao chegou, continua copiando a extenção
	
		;;ao chegar no final,
		;;os nomes "nome_arq" e "arq_out" devem terminar com "0h" (final de string) 
		
		mov [nome_arq+ebx], byte 0h
		mov [arq_out+ecx], byte 0h
		ret 

.lerArq		mov eax,5  	    ;;syscall open
		mov ebx,nome_arq    ;;nome do arquivo digitado	
		mov ecx,0	    ;;somente leitura
		mov edx,0777q	    ;;todas as permições
		int 0x80	;;chamada

		mov [id_in],eax	;;guarda identificador
		
		scanf info,400,[id_in] ;;lê 400 bytes do arquivo de entrada e coloca em "info"
		
		mov eax,6	;;syscall close
		mov ebx,[id_in] ;;fechar o arquivo de entrada
		int 0x80	;;chamada
		
		ret ;;retorno

.escreveArq	mov eax,8	;;syscall create
		mov ebx,arq_out ;;nome do arquivo de saida
		mov ecx, 0777q  ;;com todas as permições
		int 0x80	;chamada

		mov [id_out],eax ;;guarda o identificador do arquivo

		print info,400,[id_out] ;;escreve 400 de info no arquivo [id_out]

		mov eax,6	;;syscall close
		mov ebx,[id_out] ;;fechar o arquivo de saida
		int 0x80	;;chamada

		ret ;;retorno

.exit		mov eax,1 	;;syscall exit
		mov ebx,0	;;sem erros 	
		int 0x80	;;chamada
		ret
