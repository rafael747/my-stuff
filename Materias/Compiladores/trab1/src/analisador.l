/* Analisador léxico para uma linguagem de programação C-like
Bruno Barreto e Rafael Carreira */

%{
int linha=1, erros=0;
%}

DIGITO    [0-9]
ID       [a-zA-Z_][a-zA-Z0-9_]*
SINAL   [+-]?
OPERADORES "+"|"-"|"*"|"/"|"%"	
RELACIONAIS "=="|">"|"<"|">="|"<="|"!="

%%

\n				{ linha++;}

{SINAL}{DIGITO}+		printf( "Valor Inteiro encontrado: %s\t,na linha: %d\n", yytext, linha );

{SINAL}{DIGITO}+"."{DIGITO}*	printf( "Valor Real encontrado: %s,\tna linha: %d\n", yytext, linha );

if|else|for|while|return|break	|
int|float|double|char		printf( "Palavra-Chave encontrada: %s,\tna linha: %d\n", yytext, linha );	

{SINAL}{DIGITO}+{ID}		{ fprintf( stderr, "Identificador Invalido encontrado: %s,\tna linha: %d\n", yytext, linha );
				  erros++; }

{ID}				printf( "Identificador encontrado: %s,\tna linha: %d\n", yytext, linha );

{OPERADORES}			printf( "Operador encontrado: %s,\tna linha: %d\n", yytext, linha );

{RELACIONAIS}			printf( "Operador relacional encontrado: %s,\tna linha: %d\n", yytext, linha );

";"|","|":"|"."			printf( "Pontuação encontrada: %s,\tna linha: %d\n", yytext, linha );

"("|")"				printf( "Parentese encontrado: %s,\tna linha: %d\n", yytext, linha );

"["|"]"				printf( "Colchete encontrado: %s,\tna linha: %d\n", yytext, linha );

"{"|"}"				printf( "Delimitador de bloco encontrado: %s,\tna linha: %d\n", yytext, linha );

"="				printf( "Sinal de atribuição encontrado: %s,\tna linha: %d\n", yytext, linha );

"//".*$				printf( "Linha de comentario,\tna linha: %d\n", linha );

[\"][^\"]*[\"]			printf( "Cadeia de caracteres encontrado: %s,\tna linha: %d\n", yytext, linha );


[ \t]+ 		        /* Ignora espaços em branco */


.				{ fprintf( stderr, "Caractere desconhecido encontrado: %s,\tna linha: %d\n", yytext, linha );
				erros++;}
%%

int main( int argc, char **argv )
{
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
            yyin = fopen( argv[0], "r" );
    else
            yyin = stdin;
    yylex();

    if( erros > 0 )
    {
	fprintf( stderr, "\nForam encontrados %d erros durante a análise léxica!\n", erros );
        exit(1);
    }
    else
    {
	printf( "\nNenhum erro encontrado. Código analisado com sucesso!\n" );
        exit(0);
    }

}
