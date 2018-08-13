############### Makefile do dist sort ##############

SRC_CLIENT=client.c	#source do programa cliente
SRC_SORT=sort.c		#source do server de sort
SRC_MERGE=merge.c	#source do server de merge
SRC_LIB=arraysocks.h	#source da biblioteca usada

CLIENT=$(SRC_CLIENT:.c=) #compilado do analisador lexico
SORT=$(SRC_SORT:.c=) #compilado do analisador sintatico
MERGE=$(SRC_MERGE:.c=) #compilado do analisador sintatico


all: $(CLIENT) $(SORT) $(MERGE)
	@#echo "Para utilizar: ./$(CLIENT) <<< \"3 1 2 3\""

$(CLIENT): $(SRC_CLIENT) $(SRC_LIB)
	@echo "####### Compilando o client #######"
	gcc -o $(CLIENT) $(SRC_CLIENT) -lpthread -O3 -Wno-unused-result

$(SORT): $(SRC_SORT) $(SRC_LIB)
	@echo "####### Compilando o sort server #######"
	gcc -o $(SORT) $(SRC_SORT) -O3 -Wno-unused-result

$(MERGE): $(SRC_MERGE) $(SRC_LIB)
	@echo "####### Compilando o merge server #######"
	gcc -o $(MERGE) $(SRC_MERGE) -O3 -Wno-unused-result

clean:
	@echo "####### Limpando arquivos temporários #######"
	rm -rf $(CLIENT) $(SORT) $(MERGE) ordenado.txt
