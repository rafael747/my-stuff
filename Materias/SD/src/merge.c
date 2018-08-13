/* Rafael Stefanini Carreira - Trabalho de SD
*
*  Servidor de Merge
*
*/

#include "arraysocks.h"

int main(int argc, char *argv[])
{
	if(argc < 2)
        {
                printf("usage: %s <port>\n",argv[0]);
                exit(1);
        }

        listenConn(atoi(argv[1]), 1); //1 = merge server

}






