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

int sendVet(char *ip, int port, int len, double *vet)
{
        int sockfd = 0;
        int n;
        struct sockaddr_in serv_addr;

        if((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0)
        {
                printf("\n Error : Could not create socket \n");
                return 1;
        }
        memset(&serv_addr, '0', sizeof(serv_addr));
        serv_addr.sin_family = AF_INET;
        serv_addr.sin_port = htons(port);

        if(inet_pton(AF_INET, ip, &serv_addr.sin_addr)<=0)
        {
                printf("\n inet_pton error occured\n");
                return 1;
        }

        if(connect(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
        {
                printf("\n Error : Connect Failed \n");
                return 1;
        }

        // Envia o tamanho do vetor
        write(sockfd, &len, sizeof(len));
        // Envia o vetor
        n=write(sockfd, vet, len * sizeof(double));

        close(sockfd);

        if(n != len * sizeof(double))
        {
                printf("Bytes enviados != tamanho do vetor! \n");
                return 1;
        }

        return 0;
}


int recvVet(int port, int *len, double **vet)
{
        struct sockaddr_in serv_addr;
        int listenfd = 0, connfd = 0;
        struct sockaddr_in cliaddr;

        listenfd = socket(AF_INET, SOCK_STREAM, 0);
        memset(&serv_addr, '0', sizeof(serv_addr));
        serv_addr.sin_family = AF_INET;
        serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
        serv_addr.sin_port = htons(port);

	if(bind(listenfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0)
	{
		printf("bind error\n");
		return 1;
	}

        listen(listenfd, 10);
        *len=sizeof(cliaddr);
        printf("Waiting for connections on %d/tcp...\n", port);
        connfd = accept(listenfd, (struct sockaddr*) &cliaddr, len);

        // tamanho do vetor
        read(connfd, len, sizeof(*len));

        // Alocação do vetor
        *vet=(double *)malloc (*len * sizeof(double));

        // Recebe o vetor
        read(connfd, *vet, *len * sizeof(double));

        close(connfd);

}
