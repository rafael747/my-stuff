## Aula 18/09/2017

## Problemas do Mundo Real

Um problema do mundo real é aquele cujas soluções de fato interessam às pessoas. Tais problemas tentem a não apresentar uma única descrição consensual, mas tenta-se dar uma ideia geral de suas formulações. Assim, a definição dessa classe parte dos seguintes elementos

Considerando um problema de viagens aéreas:

 - **Estados**: Cada estado inclui uma posição e o tempo presente. Além disso, como o custo de uma ação pode depender de segmentos anteriores, haverá a manutenção de histórico dos estados.

 - **Estado Inicial**: Especificado pela pergunta do usuário.

 - **Ações**: Para qualquer voo a partir da posição atual, em qualquer classe de assento, partindo após o instante atual, deixando tempo suficiente para translado.

 - **Modelo de Transição**: O estado resultante de pegar um voo terá o destino do voo como a posição atual e a hora de chegada do voo como o instante atual.

 - **Teste de Objetivo**: Está no destino final especificado pelo usuário?

 - **Custo de Caminho**: Ele depende do valor da moeda, do tempo de espera, horário do voo, procedimentos de imigração, entre outros.


```

EX:   .___.
      |    \ 
      |     \
      .      \
       \      \
        .______.______.
        |             | \
        |             |  \.___.
        |             |  /  
        .________.____. /   

                 
```
  
### 3.4) Busca de soluções

Depois de formular alguns problemas, é necessário reve-los. Uma solução é uma sequencia de ações, de modo que os algoritmos de busca consideram várias sequencias de ações possíveis. As sequencias de ações possíveis que começam a partir do estado inicial formam uma arvore de busca com estado inicial na raiz, os ramos são as ações, e os nós correspondem ao espaço de estados.

```

                    *
                  /   \
                 /     \
                / \   / \
               /\ /\ /\ /\

```

Assim, um algoritmo geral de busca em arvore é apresentado a seguir:

```

função BUSCA-EM-ARVIRE (problema) retorna uma_ação
	inicializar a borda utilizando o estado inicial do problema

	repita
		se borda vazia entao retorna falha
		escolher um nó folha e o remover da borda
		se o nó contém um estado objetivo então retornar a solução correspondente
	
		expandir o nó escolhido, adicionando os nós resultantes à borda
```

### A) Para o algoritmo de busca

Existe uma estrutura de dados para manter o controle da árvore. Para cada nó:

 - Estado: Estado no espaço de estado que o nó corresponde.
 - Pai: o nó na arvore de busca que gerou este nó
 - Ação: A ação que foi aplicada ao pai para gerar o nó.
 - Custo-do-caminho: O custo do caminho do estado inicial até o nó indicado como objetivo.

### B) Medidas de Desempenho

A seguir, encontram-se alguns critérios que podem auxiliar no projeto de algoritmos de busca:

 - Completeza: O algoritmo oferece a garantia de encontrar uma solução quando ela existe?
 - Otimização: A estratégia encontra a solução ótima?
 - Complexidade de tempo: Quanto tempo ele leva para encontrar uma solução?
 - Complexidade de espaço: Quanta memória é necessária para executar a busca?


### 3.5) Estrategias de Busca Sem Informações

A busca sem informação é também chamada de **busca cega**. A expressão significa que elas não têm nenhuma informação adicional sobre estados, além daquelas fornecidas na definição do problema.

### A) Busca em Largura

A busca em larfura é uma estratégia simples em que o nó raiz é expandido primeiro, em seguida os sucessores do nó raiz são expandidos.


> Arvores

```

Função BUSCA-EM-LARGURA (problema) retorna um solução ou falha
	nó <- um nó com ESTADO = problema, ESTADO-INICIAL
	custo-de-caminho = 0
	SE problema.TESTE-DE-OBJETIVO(no.estado)
	SENAO retorne solução(nó)
	borda <- FIFIO

	repita
		se VAZIO(borda) retorna falha
		nó <- pop(borda)
		adicione nó.ESTADO para explorado
		para cada ação em problema.ACOES(nó.ESTADO) faça
			filho <- nó-FILHO(problema nó, ação)
			se (filho.ESTADO) não explorado ou borda então
				se problema.TESTE-DE-OBJETIVO(filho.ESTADO) então
					retorne solução(filho)
			borda <- INSIRA(filho, borda)
```




