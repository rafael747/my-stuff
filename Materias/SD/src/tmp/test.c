#include "arraysocks.h"
#include <stdio.h>


int main(int argc, char *argv[])
{

if(argc != 2)
{
	printf("Usage:\n%s c	for client\n%s s	for server\n", argv[0], argv[0]);
	exit(1);
}


///////////////// SERVER ///////////////

if(argv[1][0] == 's')
{ 


        double *vet;
        int len, i;

        if(recvVet(2000, &len, &vet) != 0)
        {
                printf("Ocorreram erros!\n");
                exit(1);
        }

        printf("Recebido com sucesso! %d posições\n", len);

        for(i=0; i < len; i++)
        {
                printf("vet[%d]: %.0lf\n", i, vet[i]);
        }

}

///////////// CLIENT ////////////////

else if(argv[1][0] == 'c')
{


	int tam,i;
        double *vet;

        // Le o tamanho do vetor
        puts("Tamanho do vetor: ");
        scanf("%d",&tam);

        // aloca memoria para o vetor
        vet=(double *) malloc(tam * sizeof(double));

        // Recebe o valores para o vetor
        for(i=0; i<tam; i++)
        {
                printf("\nvet[%d]: ",i);
                scanf("%lf",&vet[i]);
        }

        // Envia para o servidor
        if(sendVet("127.0.0.1", 2000, tam, vet) != 0)
        {
                printf("Ocorreram erros!\n");
                exit(1);
        }
        else
        {
                printf("Enviado com sucesso!\n");
                exit(0);

        }


}
else
{

	puts("error");


}




}

