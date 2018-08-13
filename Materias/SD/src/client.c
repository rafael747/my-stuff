/* Rafael Stefanini Carreira - Trabalho de SD
*
*  Programa cliente da ordenação distribuída
*  Recebe a entrada pela entrada padrão
*  divide o vetor em "PARTES" partes
*  envia valores usando as funções em "arraysocks.h"
*  Escreve a saída em arquivo
*
*/

#include <sys/socket.h>
#include <stdio.h>
#include <stdlib.h>
#include "arraysocks.h"
#include <pthread.h>

// numero maximo de particoes no vetor de entrada
#define PARTES 32


int counter=0;
int runningThreads=0;


// estrutura da lista circular que manter os hosts de sort/merge
typedef struct NO{
	char host[16];	//ip do host
	int port;	//porta
	struct NO *prox;
} listaC;

// estrutura que mantem os dados para a thread de ordenação
typedef struct {
	double *vet;	//referencia do vetor (no index certo)
	int len;	//tamanho do treicho à ordenar
	char host[16];	//ip do host de sort
	int port;	//porta do host
} toSortThread;

// cria uma estrutura para cada partição
toSortThread toSort[PARTES];

// lock para controle de regiao critica nas threads
pthread_mutex_t lock;

// cria uma thread ID para cada partição
pthread_t tid[PARTES];

// head das listas de hosts de sort e merge
listaC *hostsSort = NULL;
listaC *hostsMerge = NULL;

// Thread de ordenação
void *mySortThread(void *args)
{
	//ponteiro para referenciar os valores recebidos
	toSortThread *info = (toSortThread *) args;
	double *v = info->vet;
	int len = info->len;
	char *host = info->host;
	int port = info->port;

	//manda o vetor "v" para o "host"
	// o vetor é ordenado e alterado dentro dessa função 
	sort(host, port, &v, len);

	// contador de threads em execução (regiao critica)
	pthread_mutex_lock(&lock);
	runningThreads--;
	pthread_mutex_unlock(&lock);

	pthread_exit(NULL);
}

//função que faz a partição do vetor e cria as threads de ordenação
void distSort(int f, int l, double *vet, int n)
{
	//divide o vetor enquando (first) é menor que o (last-1)
	// e o número de partições (n) é menor que o numero max de partes   
	if(f < l-1 && n < PARTES)
	{	
		int m = (f + l)/2;
		distSort(f, m, vet, n*2);
		distSort(m, l, vet, n*2);
	}
	else
	{
		// v fica ajustado na posicao inicial da particao (vet[first])
		double *v;
		v=&vet[f];
		// preenche a estrutura com os dados
		toSort[counter].vet = v;
		toSort[counter].len = l-f;

		//informações do host de sort
		strncpy(toSort[counter].host, hostsSort->host, sizeof(char) * 16);
		toSort[counter].port = hostsSort->port;

		// rotaciona a lista de 
		hostsSort = hostsSort->prox;		
 
		//cria a thread
		runningThreads++;
		pthread_create(&tid[counter], NULL, mySortThread, (void *) &toSort[counter]);
		counter++;
	}	

}

void distMerge(int f, int l, double *vet, int n)
{
	// processo igual ao de distSort
	if(f < l-1 && n < PARTES)
	{	
		int m = (f + l)/2;
		distMerge(f, m, vet, n*2);
		distMerge(m, l, vet, n*2);

		double *v1, *v2;
		v1=&vet[f];
		v2=&vet[m];
		
		//faz o merge de v1 e v2 em "host"
		merge(hostsMerge->host, hostsMerge->port, &v1, m-f, &v2, l-m);
		//rotaciona a lista de hosts
		hostsMerge = hostsMerge->prox;
	}
}

//funcao que retorna uma lista circ. de tuplas no "arquivo" 
listaC *parseConfig(char *arquivo)
{
	int port, ret;
	char host[16];
	FILE *f = fopen(arquivo, "r"); //abre o arquivo para leitura
	listaC *lista = NULL;

	if(f) //se abriu com sucesso
	{
		printf("\nProcessando o arquivo: %s\n", arquivo);
	}
	else //senao
	{
		printf("\nerro: falha ao ler o arquivo: %s\n",arquivo);
		exit(1);
	}

	while(1)
	{
		ret = fscanf(f,"%s %d",host, &port); //lê host e porta do arquivo

		if(ret == EOF) //fim do arquivo
			break; 
		else if(ret != 2) //seu um valor diferente de valores
		{
			printf("erro na leitura, esperado 2 valores\n");
			exit(1);
		}	
	
		printf("Host: %s, Port: %d\n",host, port); //mostra os valores lidos
	
		listaC *no = (listaC*)malloc(sizeof(listaC)); //cria nó e insere os valores
		strncpy(no->host, host, sizeof(char) * 16);
		no->port = port;

		if(!lista) //primeira criacao
		{
			lista = no;
			lista->prox = lista;
		}
		else //lista ja existe
		{
			listaC *aux;
			aux = lista;
			while(aux->prox != lista) //vai até o final da lista
				aux = aux->prox;
			no->prox = lista;
			aux->prox = no;
		}
	}

	return lista; //retorna referencia da lista criada
}

int main(int argc, char *argv[])
{
	//preenche as listas com o conteudo do arquivo
	hostsSort = parseConfig("hosts_sort.txt");	
	hostsMerge = parseConfig("hosts_merge.txt");	

	int i;
	int tam;	//tamanho do vetor de entrada
        double *vet;	//referencia para o vetor de entrada
	
        // Le o tamanho do vetor
	//puts("Tamanho do vetor: ");
        scanf("%d",&tam);

        // aloca memoria para o vetor
        vet=(double *) malloc(tam * sizeof(double));

        // Recebe o valores para o vetor
        for(i=0; i<tam; i++)
        {
                //printf("\nvet[%d]: ",i);
                scanf("%lf",&vet[i]);
        }

	printf("\nDividindo e ordenando %d elementos em até %d partes ~ %d elementos por parte\n\n", tam, PARTES, tam/PARTES);
	
	pthread_mutex_init(&lock, NULL);

	// bubble sort distribuido
	distSort(0, tam, vet, 1);
	
	pthread_mutex_destroy(&lock);
	
	// Faz o join de todas as threads criadas
	int oldval=-1;
	for(i=0; i < counter; i++)
	{
		if(runningThreads != 0 && runningThreads != oldval)
		{
			printf("Existem %d threads em execução...\n", runningThreads);
			oldval=runningThreads;
		}
		pthread_join(tid[i], NULL);
	}
	
	printf("\nFim dos processos de ordenação, intercalando...");
	// fim das threads de ordenação
	// fase de intercalação distribuída
	distMerge(0, tam, vet, 1);

	printf("OK!\nEscrevendo a saída em \"ordenado.txt\"...");
	
	//escrevendo a saida em arquivo
	
	FILE *out = fopen("ordenado.txt", "w"); //abre o arquivo para escrita

	for(i=0; i < tam; i++)
        {
        	//printf("vet[%d]: %.0lf\n", i, vet[i]);
        	fprintf(out, "%.0lf\n",vet[i]);
        }

	printf("OK!\n");
	
}

