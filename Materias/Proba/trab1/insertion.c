#include<stdio.h>
#include<time.h>
#include<stdlib.h>

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
	for(j=2; j<n; j++)
	{
		chave=v[j];
		i=j-1;
		while(i>0 && v[i]>chave)
		{
			v[i+1]=v[i];
			i=i-1;
		}
		v[i+1]=chave;
	}
	fim = clock();
	

//	for (i=0;i<n;i++)
//          printf("\n%d",v[i]);
	printf("%lf",((double)(fim)-(double)(inicio))/(CLOCKS_PER_SEC));

}

