### Aula 09/10/2017

## B) Busca de custo Uniforme

Quando todos os custos de passos forem iguais, a busca em largura será ótima porque sempre expandeo nó mais raso não expandido. Assim, torna-se possível encontrar um algoritmo que é otimo para qualquer função de custo do passo. Em vez de expandir o nó mais raaso, a **busca de custo uniforme** expande o nó **n** com o custo caminho g(n) mais baixo. Isso é feito por meio do armazenamento da borda como uma fila de prioridade ordennada por g. A descrição algoritmica é:

```

função BUSCA-DE-CUSTO-UNIFORME (problema) retorna uma solução ou folha

	nó <- um_no_com ESTADO = problema.ESTADO-INICIAL, CUSTO-DE-CAMINHO=0
	borda <- fila-de-prioridade pelo CUSTO-DE-CAMINHO, com nó como elemento unico
	explorado <- um conjunto vazio

	repita
		se vazio?(borda) então retorna folha
		nó <- POP(borda)
		se problema.TESTE-OBJETIVO(nó.ESTADO) entao retorna Solucao(nó)
		adicionar(no.ESTADO) para explorado

		para cada ação em problema.ações(nó.ESTADO) faça
			filho <- nó-filho(problema, nó, ação)
			se (filho.ESTADO) não está na borda ou explorado então
				borda <- Insira (filho, borda)
			senão se (filho.ESTADO) está na borda com maior CUSTO-DE-CAMINHO então
				substituir aquele nó borda por filho.
```

## C) Busca em Profundidade

A busca em profundidade (DFP - Depth-first-search) sempre expande o nó mais profundo na borda atual da arvore de busca:


> img busca em profundidade

A busca prossegue imediatamente até o níle mais profundo da arvore de busca, em que não há sucessores. Há medida que esses nós são expandidos, eles são retirados da borda e, então, a busca retorna ao nó seguinte mais profundo que ainda tem sucessoes inesprorados. o algoritmo é:

```

função BUSCA-EM-PROFUNDIDADE(problema, limite) retorna solução ou corte
	BP-RECURSIVA (CRIAR-NO(problema, ESTADO-INICIAL), problema,limite)

função BP-RECURSIVA(nó, problema, limite) retorna solução ou corte
	se problema.TESTAR-OBJETIVO(no.ESTADO) entao retorna solução(nó)
	senão se limite=0 então retorna corte
	senão
		corte_ocorreu? <- falso
		para cada ação no problema.AÇOES(no.ESTADO) faça
			filho <- NO-FILHO(problema, nó, ação)
			resultado<-BP-RECURSIVA(filho, problema, limite-1)
			se resultado = corte então corte_ocorreu? <- verdadeiro
			senão se resultado != falha então retorna resultado
			
		se corte_ocorreu? então retorna corte senão retorna falha

```

## 3.6) Estratégia de busca informada (heuristica)

Trata-se de uma estratégia que utiliza conhecimento de um problema específico, além da definição do problema em si. Em geral, este tipo de estratégia baseiase na analise de uma função e suas potenciais restrições.

### A) Busca Gulosa

Esta busta tenta expandir no nó que está mais proxima no objetivo, com o fundamento de que isso pode conduzir a uma solução rapidamente. Assim, ela avalia os nós apenas usando a função heuristica. Em uma busca que usa distâncias, as vezes, ele buscará chegar ao objetivo um caminho mais custoso, mesmo que seja em linha reta.

### B) Busca A-Estrela: minimização do custo total estimado da solução

A forma de solução mais amplamente conhecida da busca de melhor escolha é chamada de busca A-estrela. Ela avalia os nós através da combinação de g(n), o custo para alcançar um nó, e a h(n), o custo para ir do nó ao objetivo: 

	
	f(n) = g(n) + h(n) 


Uma vez que g(n) dá o custo do caminho desde o nó inicial até o nó **n** e h(n) é o custo estimado do caminho de menor custo de **n** até o objetico, tem-se: f(n) é equivalente ao custo estimado da solução de menor custo por meio de **n**.
Assim, se o objetivo é encontrar a solução de menor custo, algo razoavel para se tentar em primeiro lugar, é considerar o nó com menor valor de g(n) + h(n). Acontece que essa estratégia é interessante se a função heuristica h(n) satisfaça determinadas condições e, portanto, a busca A-estrela será completa e ótima.

#### B.1) Condições para otimalidade: admissibilidade e consistencia

A primeira condição requerida para otimalidade é que h(n) seja uma heuristica admissível. Uma heuristica admissivel é a que nunca superestima o custo de atingir o objetivo. Devido a g(n) ser o custo real para alcançar **n**, ao longo do caminho atual, e, dessa forma, considerando f(n) = g(n) + h(n), tem-se com consequencia imediata que f(n) nunca irá superestimar o verdadeiro custo de uma solução ao longo do caminho atual por meio de **n**.

Uma segunda condição um pouco mais forte chamada **consistencia** é necessária apenas para buscas mais detalhadas de A-estrela em grafos mais complexos. Uma heuristica h(n) será consistente se, para nó **n** e para todo sucessor n' de n, gerado por uma ação **a**, o custo estimado de alcançar o objetivo de **n**  não for maior do que o custo de chegar a n' mais o custo estimado de alcançar o objetivo em:

		h(n) <= c(n,a,n') + h(n')

Trata-se de uma forma genérica de **desigualdade triangular**, que estipula cada um dos lados de um triangulo nao pode ser maior que a soma dos outros dois lados. Para uma heuristica admissivel, a desigualdade faz todo o sentido: por exemplo, se houvesse uma rota de **n** para Gn qualquer via n' que fosse mais barata do que h(n) e que violasse a propriedade de que h(n) está em um limite inferior de custo para chegar a Gn
