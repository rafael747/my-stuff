#include<stdio.h>
#include<time.h>
#include<stdlib.h>

void selection_sort(int num[], int tam) 
{ 
  int i, j, min, aux;
  for (i = 0; i < (tam-1); i++) 
   {
    min = i;
    for (j = (i+1); j < tam; j++) {
      if(num[j] < num[min]) {
        min = j;
      }
    }
    if (i != min) {
      aux = num[i];
      num[i] = num[min];
      num[min] = aux;
    }
  }
}

main()
{

	int i, j,n;
	int chave;
	int *v;
	clock_t inicio, fim;

	scanf("%d",&n);

	v=(int*)malloc(n*sizeof(int));

	for (i=0;i<n;i++)
            scanf("%d",&v[i]);

	inicio= clock();//FunÃ§Ã£o que mede o tempo de execuÃ§Ã£o
	selection_sort(v,n);
	fim = clock();
	

//	for (i=0;i<n;i++)
//          printf("\n%d",v[i]);
	printf("%lf",((double)(fim)-(double)(inicio))/(CLOCKS_PER_SEC));

}

