#include <time.h>
#include <stdio.h>
#include <stdlib.h>

int main(void)
{

	int *vet;
	int tam,valor;
	int i,j;
	int gap=1;
	double sec;
	clock_t inicio,fim;

	scanf("%i",&tam);

	vet=(int*)malloc(tam*sizeof(int));

	for(i=0;i<tam;i++)
		scanf("%i",&vet[i]);

	inicio=clock();

	while(gap<tam){
		gap = (3*gap)+1;
	}
	while(gap > 1){
		gap /= 3;
		for(i=gap;i<tam;i++){
			valor=vet[i];
			j=i-gap;
			while(j>=0 && valor< vet[j]){
				vet[j+gap]=vet[j];
				j-=gap;
			}
			vet[j+gap]=valor;
		}
	}
	fim=clock();
	
	printf("%lf",((double)(fim)-(double)(inicio))/(CLOCKS_PER_SEC));

	return 0;
}
