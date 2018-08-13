## Aula 04/09/2016

> Diagrama - "a estrutura do agente baseado em modelo é"


#### Descrevendo um algoritmo

```

funcao agente-modelo (percepcao) retorn uma_acao
	persistente estado
		    modelo
		    regras
		    acao

	estado <- atualizar-estado(estado, acao, percepcao, modelo)
	regra <- regra-correspondente(estado, regras)
	acao <- regra, acao
	retorna(acao)

```

O que se percebe é que o estado interno atual do agente pe combinado com o estado interno antigo para gerar uma descrição atualizada do estado. No entanto, é sempre importante considerar um grau de incerteza do estado atual.

### C) Agentes baseados em objetivos

Conhecer algo sobre o estado atual do ambiente nem sempre é suficiente para decisir o que fazer. Assim, o agente precisa de alguma espécie de informação sobre objetivos que descreva situações desejáveis. Com isso, pode-se escolher ações que alcancem o objetio.
A seguir, encontra-se a estrutura do agente baseado em objetivo:

> diagrama "agente baseado em objetivo"

Uma ação, nesse contexto, pode ser:

 - Imediata
 - Complexa: demanda busca e planejamento.

O agente baseado em objetivo é mais flexivel (embora, em alguns casos, menos eficiente), pois pode ter o seu comportamento alterado facilmente.

### D) Agentes baseados em utilidade

Sabe-se que, os objetivos não sao realmente suficientes para gerar um comportamento de alta qualidade na maioria dos ambientes. Os objetivos simplesmente permitem uma distinção binária entre estalhos, enquanto que uma avaliação mais minuciosa sobre as medidas de desempenho geral garantem um resultado mais exato da operação do agente. A partir disso, foca-se em um termo denominado utilidade.
Uma medida de desempenho permite que sejam atribuidas pontuações para qualquer sequencia de estados do ambiente, o que permite a escolha de ações e elementos mais ou menos desejáveis. Assim, a **função de utilidade do agente**  é essencial para mensurar o grau de qualidade de fatores internos do agente. Se a função de utilidade interna e a medida externa de desempenho estiverem em acordo, o agente obterá sucesso em sua escolha.
A seguir encontra-se a estrutura do agente baseado em utilidade:

> Diagrama - "a estrutura de agente baseado em utilidade"

A observabilidade e estocasticidade são onipresentes no mundo real e assim, a tomada de decisao sobre o grau de sucesso possui elementos de incerteza. Assim, quando um agente baseado em utilidade escolhe uma ação que **maximiza a utilidade esperada** dos resultados, trata-se de algo desejável e que se adequa à condições mais reais. Com isso um agente atua de forma mais explicita sobre as condições existentes e ofertadas pelo ambiente, o que impactará diretamente na **fidelidade** desse agente.







	
