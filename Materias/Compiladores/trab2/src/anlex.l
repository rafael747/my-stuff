/* AAnalisador léxico para uma linguagem de programação C-like
Bruno Barreto e Rafael Carreira */

%{
#include <stdio.h>
#include "ansin.tab.h"

extern int linha,erros;
%}

DIGITO    [0-9]
ID       [a-zA-Z_][a-zA-Z0-9_]*
SINAL   [+-]?
OPERADORES "+"|"-"|"*"|"/"|"%"	
RELACIONAIS "=="|">"|"<"|">="|"<="|"!="


%%

\n			{ linha++;}

if	return IF;
else	return ELSE;
for	return FOR;
while	return WHILE;
return	return RETURN;
int	|
float	|
char	return TIPO;

{SINAL}{DIGITO}+	{
	return INTEIRO;
}

{SINAL}{DIGITO}+"."{DIGITO}*	{
	return REAL;
}

 /* Identificador Invalido */
{SINAL}{DIGITO}+{ID}	{
	return ERRO;
	erros++;
}

{ID}	{
	return IDENTIFICADOR;
}

{OPERADORES}	{
	return OPERADOR_ARIT;
}

{RELACIONAIS}	{
	return OPERADOR_REL;
}

"||"|"&&"	{
	return OPERADOR_LOG;
}

";"	return SEMI_COLON;
","	return COMMA;
"("	return ABRE_PAR;
")"	return FECHA_PAR;
"{"	return ABRE_CHA;
"}"	return FECHA_CHA;
"="	return ATRIB;

 /* Comentarios em linha */
"//".*$

 /* Cadeia de caracteres */
[\"][^\"]*[\"]	{
	return STRING;
}

[ \t]+	/* Ignora espaços em branco */


 /* Resto */
.	{
	return ERRO;
	erros++;
}

