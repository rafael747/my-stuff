############### Makefile do analisador lexico e sintatico ##############

EXEC=analisador	#nome do executavel

SRC_LEX=anlex.l #source do analisador lexico
SRC_SIN=ansin.y #source do analisador sintatico

LEX=$(SRC_LEX:.l=.c) #compilado do analisador lexico
SIN=$(SRC_SIN:.y=.tab.c) #compilado do analisador sintatico


all: $(LEX) $(SIN)
	@echo "####### Criando o analisador! #######"
	gcc $(LEX) $(SIN) -o $(EXEC) -lfl
	@echo "####### Done! #######"
	@echo "Para utilizar: ./$(EXEC) < texto_a_ser_analisado"

$(LEX): $(SRC_LEX)
	@echo "####### Criando o arquivo de analise lexica! #######"
	flex -o $(LEX) $(SRC_LEX)

$(SIN):	$(SRC_SIN)
	@echo "####### Criando o arquivo de analise sintatica! ######"
	bison -d $(SRC_SIN)

clean:
	rm -rf $(LEX) $(SIN) $(EXEC) $(SIN:.c=.h) $(SRC_SIN:.y=.xml) $(SRC_SIN:.y=.html)


html: $(SRC_SIN)
	@echo "####### Criando descrição do automato em HTML ######"
	bison -d -x $(SRC_SIN)
	@xsltproc /usr/share/bison/xslt/xml2xhtml.xsl $(SRC_SIN:.y=.xml) > $(SRC_SIN:.y=.html) || echo "xsltproc não instalado!"
	@echo "####### Done! #######"
	@echo "Abra o arquivo criado ($(SRC_SIN:.y=.html)) em algum navegador"

