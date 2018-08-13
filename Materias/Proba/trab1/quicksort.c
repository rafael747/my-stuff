#include <stdio.h>
#include <time.h>
#include <stdlib.h>

void quicksort(int vet[],int esq,int dir){

	int i,j,x,y;
	i=esq;
	j=dir;
	x=vet[(esq+dir)/2];

	while(i<=j){
			while(vet[i] < x && i < dir)
				i++;
			while(vet[j] > x && j > esq)
				j--;
			if(i<=j){
				y=vet[i];
				vet[i]=vet[j];
				vet[j]=y;
				i++;
				j--;
			}
	}
	if(j > esq)
		quicksort(vet,esq,j);
	if(i < dir)
		quicksort(vet,i,dir);
}

int main(void){

	int *vet;
	int tam,i;
	clock_t inicio,fim;

	scanf("%i",&tam);

	vet=(int*)malloc(tam * sizeof(int));

	for(i=0;i<tam;i++)
		scanf("%i",&vet[i]);

	inicio=clock();
	quicksort(vet,0,tam-1);
	fim=clock();

	printf("%lf",((double)(fim)-(double)(inicio))/(CLOCKS_PER_SEC));


	return 0;
}
