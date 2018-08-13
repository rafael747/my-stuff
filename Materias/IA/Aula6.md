### Aula 11/09/2017

## 3) Resolução de Problemas

Neste ponto serão abordados elemetnos para analise sobre resolução de problemas.

### 5.1) Agentes de resolução de problemas

Os agentes inteligentes devem maximizar sua média de desempenho. Para auxiliar nesse prcesso, o agente deve adotar um objetivo que desejar satisfazer. A formulação de objetivos, baseada na situação atual e na medida de desempenho do agente, é o primeiro passo para a resolução de problemas.

A tarefa do agente é descobrir como agir, agora e no futuro, para que alcance o estado objetivo. Antes de poder fazer isso, ele precisa decidir que tipo de ações e estados devem ser considerados, dado um objetivo.

Em geral, um agente com vários opções imediatas de valor desconhecido pode decidir o que fazer examinando primeiroações futuras que levam eventualmente a estados de valor conhecido. Para ser mais específico, por examinar açõesvfuturas, deve-se ser mais especificos sobre sobre as propriedades do ambiente. assim, serão tratados, inicialmente:

 - Ambiente observável;
 - Ambiente discreto;
 - Ambiente conhecido;
 - Ambiente deterministico.

A solução para um problema qualquer é uma seguencia fixa de ações.

O processo de procura por tal sequencia de ações que alcançam o objetivo é chamado de **busca**.
Assim, projeta-se um algoritmo de busca básico para resolver tal problema:

```
Funcao agente-de-resolucao (percepcao) retorna um ação
	persistente:    seq 	 //sequencia de ações
			estado 	 //alguma descrição do estado atual
			objetivo //um objetivo
			problema //uma formulação
	estado <- atualizar-estado(estado, percepcao)
	se seq está vazia entao faça
		objetivo <- formular-objetivo(estado)
		problema <- formular-problema(estado, objetivo))
		seq <- busca(problema)
		se seq == falhar então retorne um acao nula
	ação <- primeiro(seq
	seq <- resto(seq)
retornar(ação)

```

### 3.2) Problemas e soluções bem definidos

Um problema pode ser definido formalmente por cinco componentes:

 - O estado inicial em que o agente começa;
 - Uma descrição das ações possíveis que estão disponíveis para o agente. Dado um estado particular **s**, ação(s) devolve um conjunto de ações que podem ser executadas em s. Cada uma das ações descritas é aplicável em s.
 - Uma descrição do que cada ação faz: modelo de transição. resultado(s,a) => função que devolve o estado que resulta de executar uma ação **a** em estado **s**. Define-se aqui o sucessor: qualquer estado acessivel a partir de um determinado estado por única ação. Assim, tem origem o espaço do estado, que pe: etado inicial, ações e o modelo de transições. Este espaço de estado pode ser definido como um grafo.

 - O teste de objetivo, que determina se um estado é um estado objetivo.
 - Uma função de custo de caminho que atribui um custo numérico a cada caminho. O agente de resolução de problemas escolhe uma função custo que reflete sua própria medida de desempenho. De maneira simplificada, o custo de um caminho pode ser descrito como a soma dos custos das ações individuais ao longo de caminho.

> Solução: é um caminho desde o estado inicial até um objetivo. Como a quantidade da solução é medida pela função custo, uma solução otima é a que tem menor custo de caminho.

### 3.3) Exemplos de Problemas

A seguir, serão apresentados métodos para o entendimento e resolução de problemas.

#### A) Problemas de mundo simplificado

Um mundo simplificado se destina a ilustrar ou exercitar diversos métodos de resolução de problemas. Portanto, utilizável por diferentes pesquisadores para comparar o desempenho dos algoritmos.

Como exemplo, considera-se o problema com o aspirador de pó, apresetado anteriormente:

 - Estados: o estado é determinado tanto pela posicao dos agentes quanto da sujeira. O agente fica entre duas posições, as quais podem comter sujeira ou não (ambiente: n posições. com nx2^n estados)
 - Estado inicial: qualquer estado pode ser designado como inicial.
 - Ações: três: esquerda, direita e aspirar.
 - Modelo de transição: as ações tem efeito esperadol.
 - Teste de objetivo: verifica se todos os quadrados estão limpos.
 - custo do caminho: cada passo custo 1.

> img aspirador


