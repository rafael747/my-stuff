// arquivo de teste para o analisador lexico
// escrito por Rafael Carreira e Bruno Carvalho

#include <stdlib.h>
#include <stdio.h>
int add(int, int);

int main()
{
	//Declaracao de variaveis
	int n1, n2;
	int soma;

	n1 = 1;
	n2 = 10;
		
	soma = add(n1, n2);

	if(soma > 50)
	{
		printf("Deu um número grande!");
		exit(1);
	}
	else
	{
		printf("Tá de boa!");
		exit(0);
	}
	
}

int add(int a, int b)
{
	int i,soma; //contador e acumulador

	for(i=a; i<=b; i=i+1)
	{
		soma=soma+i;
	}
	
	return(soma);
}		
