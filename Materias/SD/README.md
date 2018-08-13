## Relatório do Trabalho de Sistemas Distribuídos
 
#### Rafael Stefanini Carreira - 02 de julho de 2017
 
 
### Ordenação distribuída
 
 
O programa ordena valores inteiros armazenados em um vetor. A estratégia utilizada é a de merge-sort, sendo utilizados dois tipos de servidores, um de ordenação e outro de intercalação, chamados em momentos distintos pelo cliente.
O servidor de ordenação utiliza o algoritmo bubble sort, enquanto o servidor de merge utiliza a estratégia de intercalação tradicional do merge-sort.
O programa cliente fica encarregado de receber a entrada e particionar o vetor em até 32 partes, independente do tamanho da entrada. Após a partição da entrada, o programa cliente envia as partes para os servidores de ordenação, e então, duas partes para os servidores de merge em cada fase de merge.
Após a ordenação das 32 partes do vetor e sua intercalação, o programa escreve o resultado final no arquivo de saída (ordenado.txt).
 
 
### Utilização
 
Para compilar o programa client e os servidores de sort e merge, entre na pasta **src** e execute o comando **make**. É necessário que as ferramentas **gcc** e **make** estejam instaladas:

	cd src
	make
 
Para utilizar o programa de ordenação distribuída é necessário executar os servidores de sort e de merge. Os hosts e portas utilizados no programas então em **hosts_sort.txt** e **hosts_merge.txt**.

	./sort <porta>
	./merge <porta>
 
O programa de ordenação recebe os valores na entrada padrão. Primeiro o programa lê o tamanho do vetor e em seguida os elementos. Dessa forma, para realizar a ordenação de 200.000 elementos, digite no terminal:

	echo 200000 > entrada.txt
	seq 200000 | shuf >> entrada.txt
	./client < entrada.txt
 
É possível ainda gerar a entrada no momento da execução do programa **client**. Para realizar a ordenação de 200.000 elementos, digite no terminal:

	./client < <(echo 200000;seq 200000|shuf)
 
Para limpar os arquivos temporários resultante das compilações e processos de sort ou merge em execução digite o seguinte:

	make clean
	killall sort merge

