/* Rafael Stefanini Carreira - Trabalho de SD
*
*  Biblioteca com as funções de: 
*  Abertura de conexões,
*  Leitura e escrita em sockets,
*  Ordenação (bubble) e Intercalação (merge).
*
*/

#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <arpa/inet.h>

// Prototipação das funções
int readsock(int, double*, int);
int readsock2(int, double*, int);
int writesock(int, double*, int);
int writesock2(int, double*, int);
int closesock(int);


/* Função que abre conexão com um host (ip) em uma determinada porta (port).
   Se a conexão for iniciada com sucesso, retorna o socket da conexão. */

int openConn(char *ip, int port)
{
        int sockfd = 0;
        struct sockaddr_in serv_addr;

        if((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0)
        {
                printf("\n Erro: Não foi possível criar o socket \n");
                exit(1);
        }
        memset(&serv_addr, '0', sizeof(serv_addr));
        serv_addr.sin_family = AF_INET;
        serv_addr.sin_port = htons(port);

        if(inet_pton(AF_INET, ip, &serv_addr.sin_addr)<=0)
        {
                printf("\n Erro: Não foi possível utilizar o IP informado(%s) \n", ip);
                exit(1);
        }

        if(connect(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
        {
                printf("\n Erro: Não foi possível conectar no IP %s, na porta %d \n", ip, port);
                exit(1);
        }

	return sockfd;
}

/* Função de sort do lado cliente.
   Recebe o endereço de uma posição do vetor e a quantidade de elementos
   Envia o tamanho e os elementos para o IP na porta informada. 
   Após a ordenação, recebe o vetor ordenado na mesma posição */

int sort(char *ip, int port, double **vet, int len)
{
	int sockfd, n;
	sockfd=openConn(ip, port);
	uint32_t nlen = ntohl(len);	//network order
	
        // Envia o tamanho do vetor
        write(sockfd, &nlen, sizeof(nlen));

        // Envia o vetor
	writesock(sockfd, *vet, len * sizeof(double));

	// Recebe o vetor de volta
	readsock(sockfd, *vet, len * sizeof(double));

	// fecha a conexão
        close(sockfd);

        return 0;
}

/* Função de merge do lado cliente.
   Recebe dois vetores e a quantidade de elementos em cada um.
   Envia os vetores e seus tamanhos ao IP na porta informada.
   Após a intercalação, recebe os valores, ocupando a possição de ambos os vetores */

int merge(char *ip, int port, double **v1, int len1, double **v2, int len2)
{
	int sockfd, n;
	sockfd=openConn(ip, port);
	
	// network order
	uint32_t nlen1 = ntohl(len1);
	uint32_t nlen2 = ntohl(len2);


        // Envia o tamanho do vetor 1
        write(sockfd, &nlen1, sizeof(nlen1));

        // Envia o tamanho do vetor 2
        write(sockfd, &nlen2, sizeof(nlen2));

        // Envia o vetor 1
        writesock(sockfd, *v1, len1 * sizeof(double));

        // Envia o vetor 2
        writesock(sockfd, *v2, len2 * sizeof(double));

	// Recebe o vetor de volta (em v1)
	readsock(sockfd, *v1, (len1+len2) * sizeof(double));

	// fecha a conexão
        close(sockfd);

        return 0;
}

/* Função de sort do lado servidor
   Recebe o vetor do socket informado (connfd)
   Ordena os valores usando bubble sort
   Envia os valores de volta ao cliente */

int rsort(int connfd)
{
	int len, i, j, tmp;
	double *vet;
	uint32_t nlen;
	
	// tamanho do vetor
        read(connfd, &nlen, sizeof(nlen));
	len=ntohl(nlen);

	printf("[SORT] Tamanho da entrada: %d elementos\n",len);

        // Alocação do vetor
        vet=(double *)malloc (len * sizeof(double));
	
        // Recebe o vetor
	readsock(connfd, vet, len * sizeof(double));
	
	//ordena o vetor (bubble sort)
	for(i=len; i >= 0; i--)
	{
		for(j=0; j<i-1; j++)
		{
			if(vet[j] > vet[j+1])
			{
				tmp=vet[j+1];
				vet[j+1]=vet[j];
				vet[j]=tmp;
			}
		}
	}

	// Envia de volta	
	writesock(connfd, vet, len * sizeof(double));

	free(vet);

	// Fecha a conexão
        closesock(connfd);
        return 0;
}

/* Função de merge do lado servidor
   Recebe dois vetores do socket informado (connfd)
   Faz a intercalação dos valores recebidos (que já estão ordenados)
   Envia o vetor ordenado de volta ao cliente */

int rmerge(int connfd)
{

	int len1, len2, i, j, k;
	double *v1, *v2, *vt;
	uint32_t nlen1, nlen2;	

	// tamanho do v1
        read(connfd, &nlen1, sizeof(nlen1));
	len1 = ntohl(nlen1);
	printf("[MERGE] Tamanho da entrada v1: %d\n",len1);

	// tamanho do v2
        read(connfd, &nlen2, sizeof(nlen2));
	len2 = ntohl(nlen2);
	printf("[MERGE] Tamanho da entrada v2: %d\n",len2);

        // Alocação do vetor
        v1=(double *)malloc (len1 * sizeof(double));
        v2=(double *)malloc (len2 * sizeof(double));
	
        // Recebe o vetor 1
	readsock(connfd, v1, len1 * sizeof(double));
	
        // Recebe o vetor 2
	readsock(connfd, v2, len2 * sizeof(double));
	
	// Alocação do vetor resultante
	vt=(double *)malloc ((len1 + len2) * sizeof(double));
	
	// intercala o vetor
	i=0; j=0; k=0;
	
	while(i < len1 && j < len2)
	{
		if(v1[i] <= v2[j]) vt[k++] = v1[i++];
		else vt[k++] = v2[j++];
	}
	while(i < len1) vt[k++] = v1[i++];
	while(j < len2) vt[k++] = v2[j++];
	
	
	// Envia de volta
	writesock(connfd, vt, (len1+len2) * sizeof(double));

	free(v1);
	free(v2);
	free(vt);

        closesock(connfd);
        return 0;
}


/* Função usada no lado servidor para escutar por conexões.
   Escuta na porta informada (port)
   Executa a opção desejada (op):
	0 - Faz a ordenação
	1 - Faz a intercalação
*/

int listenConn(int port, int op) //0 for sort, 1 for merge
{
	struct sockaddr_in serv_addr;
	struct sockaddr_in cliaddr;
	int listenfd = 0, connfd = 0, len = 0;
	char buff[1025];

        listenfd = socket(AF_INET, SOCK_STREAM, 0);
        memset(&serv_addr, '0', sizeof(serv_addr));
	memset(buff, '0', sizeof(buff));
        serv_addr.sin_family = AF_INET;
        serv_addr.sin_addr.s_addr = htonl(INADDR_ANY); //Responde qualquer ip 
        serv_addr.sin_port = htons(port);

	if(bind(listenfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0)
	{
		printf("Erro: Não foi possível escutar na porta %d\n", port);
		exit(1);
	}

        listen(listenfd, 100); //tamanho da fila de espera: 100
        len=sizeof(cliaddr);

	// imprime a operação, dependendo do valor de "op"
	op? printf("[MERGE] ") : printf("[SORT] ");
 	printf("Esperando por conexões na porta %d/tcp\n", port);

	while(1)
	{
        	connfd = accept(listenfd, (struct sockaddr*) &cliaddr, &len);
		inet_ntop(AF_INET, &cliaddr.sin_addr, buff, sizeof(buff));
        	//printf("Connection from %s, port %d\n", buff, ntohs(cliaddr.sin_port));

		// Faz o fork do processo e executa a operação desejada
		if(fork() > 0 )
		{
			if(op == 0)
				rsort(connfd);
			else
				rmerge(connfd);
			exit(0);
		}
	}

	exit(0);
}

/* Função de leitura em socket
   Utiliza a função ntohl (network order to host long)
   Permite receber valores de multiplos bytes de tamanho de hosts
   de arquiteturas diferentes (big endian vs little endian). */

int readsock(int socket, double *buff, int len)
{ 
	int n=0, i, total=0;
	uint32_t val;

	for(i=0; i<len/sizeof(double); i++)
	{
		n=read(socket, &val, sizeof(uint32_t));
		total+=n;
		buff[i]=(double)ntohl(val);
	}

	//retorna o valor de bytes recebidos
	return total;
}


/* Função de escrita em socket
   Utiliza a função htonl (host to network long)
   Permite enviar valores de multiplos bytes de tamanho para hosts
   de arquiteturas diferentes (big endian vs little endian). */

int writesock(int socket, double *buff, int len)
{ 
	int n=0,i, total=0;
	// novo tamanho (em uint_32)
	int nlen=(len/sizeof(double))*sizeof(uint32_t);
	
	//aloca um novo vetor de uint_32 
	uint32_t *val = (uint32_t*) malloc(nlen);

	// faz a conversão em network order
	for(i=0; i<len/sizeof(double); i++)
		val[i]=htonl(buff[i]);
	
	//envia os valores convertidos
	while(total < nlen){
		n=write(socket, val, nlen);
		total+=n;
		val=val+n;
	}

	//retorna o valor de bytes enviados
	return total;
}


/* Função que fecha a conexão de um socket
   Descata os bytes não lidos,
   Faz o shutdown do socket (declara que nao deseja mais se comunicar)
   Fecha a conexão */

int closesock(int socket)
{	
	int n;
	char discard[99];
	n=read(socket,discard, sizeof(discard));
	while(n)
		 n=read(socket,discard, sizeof(discard));
	shutdown(socket, 1);
	close(socket);

}
