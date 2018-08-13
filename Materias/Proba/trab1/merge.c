#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void intercala(int p, int q, int r, int v[]) 
{
   int i, j, k, *w;
   w = (int*)malloc ((r-p) * sizeof (int));
   i = p; j = q;
   k = 0;

   while (i < q && j < r) {
      if (v[i] <= v[j])  w[k++] = v[i++];
      else  w[k++] = v[j++];
   }
   while (i < q)  w[k++] = v[i++];
   while (j < r)  w[k++] = v[j++];
   for (i = p; i < r; ++i)  v[i] = w[i-p];
   free (w);
}

void mergesort(int p, int r, int v[])
{
	if(p < r-1)
	{
		int q = (p + r)/2;
		mergesort (p, q, v);
		mergesort (q, r, v);
		intercala(p, q, r, v);
	}
}


main()
{
	int i,n,*v;
	clock_t inicio,fim;

	scanf("%d",&n);

        v=(int*)malloc(n*sizeof(int));

        for (i=0;i<n;i++)
            scanf("%d",&v[i]);

        inicio=clock();
	mergesort(0,n,v);
	fim=clock();

        printf("%lf",((double)(fim)-(double)(inicio))/(CLOCKS_PER_SEC));
}
