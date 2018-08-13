## Aula Mon Oct 30 2017

O Algoritmo de têmpera simulada pode ser verificado a seguir:

```
função TEMPERA-SIMULADA ()problema, escalonamento) retorna um estado solução

	entradas:  problema, um problema
		   escalonamento, um escalonamento de tempo para temperatura
	
	atual <-CRIAR-NO(problema.ESADO-INICIAL)
	para t=1 até infinito faça
		T <- escalonamento(t)
		se T=0 então retornar carente
		proximo <- um sucessor de atual selecionado aleatoriamente
		deltaE <- proximo.VALOR - atual.VALOR
		se deltaE > 0 estão atual <- proximo
		senão atual <- proximo somente com probabilidade e^(deltaE/T)
	fim_para
fim_função
```

### 4.3) Algoritmos Genéticos

Um algoritmo genético (AG) é uma estratégia evolutiva, na qual os estados sucessores são gerados pelas combinação de dois estados pais, em vez de serem gerados pela modificação de um único estado, como alguns algoritmos evolutivos operam.

Os AGs começam com um conjunto de K estados aleatoriamente, chamado população. Cada estado, ou indivíduo, é representado como uma cadeia sobre um alfabeto finito.


Como exemplo de um AG, tem-se uma sequencia de dígitos:

> img tabela exemplo. cruzamento, mutação, etc 


A partir do exemplo anteriormente apresentado, destaca-se o processo de execução de um AG. No segmento A, verifica-se uma população inicial com 4 cadeias de 8 digitos cada, de modo a toma-los como nossos exemplos de inicialização.

No segmento B, cada estado é avaliado pela função de adaptação. Uma função de adaptação deve retornar valores mais altos para estados melhores, o que pode ser verificado pelos números à esquerda (24, 23, 20, 11). Nesse caso, a probabilidade de um indivíduo ser escolhido para a reprodução é **diretamente proporcional à sua pontuação de adaptação**, e as porcentagens são mostradas junto as pontuações  brutas. No segmento C, dois pares escolhidos aleatoriamente são selecionados para a reprodução, de acordo com as probabilidades descritas no segmento B. Note que um indivíduo é selecionado 2 vezes, e um indivíduo não é selecionado de modo algum. Este tipo de seleção, ou regra, pode demonstrar maior ou menor facilidade de convergencia dependendo do que se escolhe. Para cada par ser cruzado, é escolhido ao acaso um ponto de **cruzamento** dentre as posições da cadeia. Neste caso, os pontos de cruzamento escolhidos estão depois do terceiro digito no primeiro par e depois no quinto digito do segundo par.

No segmento D, são apresentados os proprios descendentes por cruzamento de cadeias pais no ponto de crossover. Em geral, a população é bastante diversa no inicio do processo e, assim, o cruzamento frequentemente executa grandes passos no estado de espaços bem no inicio do processo de busca e passos menores adiante, quando a maioria dos individuos é semelhante.

Finalmente, no segmento E, cada posição está sujeita à **multação** aleatoria, com uma pequena probabilidade independente. Nesse caso, houve a mutação no primeiro, terceiro e quarto descendente.

Uma das grandes vantagens, se não a maior, é a possibilitade de se fazer cruzamento no algoritmo genético.

A seguir é apresentado a estratégia para implementação de um AG:

```

funcao AG(população, FN-ADAPTADA) retorna um individuo
	entradas:	população, um conjunto de indivíduos
			FN-ADAPTA, função que mede a adaptação

	repita
		nova_população <- conjunto vazio
		para i=0 até tamanho(população) faça
			x<- seleção-aleatória(população, FN-ADAPTA)
			y<- seleção-aleatória(população, FN-ADAPTA)
			filho <- reproduz(x,y)
			pequena probabilidade aleatoria então filho <- mutação(filho)
			adicionar filho a nova população
		fim_para
		
		população <- nova população
		
	até infinito adaptado ou tempo ter diso suficiente
retornar o melhor individuo de acordo com FN-ADAPTA

função reproduz(x,y) retorna indivíduo
	entradas: x,y, individuos pais

	n <- comprimento(x)c (aleatorio de 1 a n)
retornar concatena(subcadeia(x,1c), subcadeia(y, c_1, n))

```


	
