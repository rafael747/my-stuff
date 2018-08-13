;Rafael Carreira
;Daniel Perez

;Trabalho de Micro e Micro
;programa que receba 32 inteiros (entre 0 e 128)
;armazene-os a partir de 20h, ordene-os e apresente na porta B

	list p=16F873A

;Definição de alguns endereços

indf	equ	00h
pcl	equ	02h
status	equ	03h
fsr	equ	04h
porta	equ	05h
trisa	equ	05h
portb	equ	06h
trisb	equ	06h

count	equ	40h
end1	equ	41h
end2	equ	42h
val1	equ	43h
val2	equ	44h
oldVal	equ	45h
delcntr1 equ	46h
delcntr2 equ	47h

;
org 00
;Inicio do programa

start	bsf status,5 ;Seleciona banco 1
	movlw D'255'; w=B'11111111'
	movwf trisb ; todos os bits da porta b são entrada
	bcf status,5 ;Seleciona banco 0
;
;Leitura dos valores

	movlw 20h	;primeira posição
	movwf fsr
	movfw portb	;guarda valor inicial da porta B
	movwf oldVal
Ler	call lerVal	;le valor e coloca em W
	incf fsr,01h	;prox val
	movlw 24h ;40h
	xorwf fsr,0	;se fsr ja chegou em 40
	btfss status,2	;se for, salta
	goto Ler	;se nao, volta a ler
	goto ordena

lerVal	movfw portb	;pega novo valor da porta B
	xorwf oldVal,0	;compara com valor antigo
	btfsc status,2	
	goto lerVal	;se for igual (zero flag=1) le de novo
	movfw portb	;se for diferente
	movwf indf	;grava valor
	movwf oldVal
	return

; os valores lidos entao entre 20h e 3Fh
; etapa de ordenação

	;3Fh

ordena	movlw 24h ;40h	;ultimo endereço a ser manipulado
	movwf count	
loop	movlw 20h	;endereço do primeiro valor
	movwf end1
	movlw 21h	;endereço do segundo valor
	movwf end2
proxEnd	call compara	;compara e coloca o maior valor em end2
	incf end1,1
	incf end2,1	;avança posicao
	movfw count
	xorwf end2,0	;verifica se end2 chegou no ultimo endereço
	btfss status,2
	goto proxEnd	;se nao chegou, verifica prox endereço
	movlw 22h
	xorwf count,0	;verifica se count ja chegou em 22h (ultima iteracao)
	btfsc status,2
	goto mostra	;se chegou, mostra os valores
	decf count,1	;se nao, decrementa count e continua
	goto loop

compara	movfw end1
	movwf fsr
	movfw indf
	movwf val1	;val1 recebe valor de end1
	incf fsr,1
	movfw indf
	movwf val2	;val2 recebe valor de end2
	subwf val1,0	;compara valores
	btfsc status,2	;verifica zero flag
	return		;são iguais, nao precisa trocar
	btfsc status,0	;verifica carry/borrow
	call troca	;val1 é maior, precisa trocar
	return		;val2 é maior, nao precisa trocar

troca	movfw end1	;troca valor de end1 com end2
	movwf fsr
	movfw val2	;coloca val2 em end1
	movwf indf
	movfw end2
	movwf fsr
	movfw val1	;coloca val1 em end2
	movwf indf
	return

; os valores ja estão ordenados
; nesse passo eles nao impressos na porta B

mostra	bsf status,5
	clrw
	movwf trisb
	bcf status,5

	movlw 20h	;posicao do primeiro valor
	movwf fsr
prox	movfw indf
	movwf portb	;coloca na porta B
	;call delay
	incf fsr,1
	movlw 24h ;40h	;posicao do ultimo valor
	xorwf fsr,0
	btfss status,2	;se nao chegou no ultima
	goto prox	;continua imprimindo os valores
	goto start	;se acabou, reinicia o processo
	end
	
;delay	movlw D'100'
;	movwf delcntr2
;outer	movlw D'100'
;	movwf delcntr1
;inner	nop
;	nop
;	decfsz delcntr1,1
;	goto inner
;	decfsz delcntr2,1
;	goto outer
;	return
;
;	end		;acabou de imprimir os valores

