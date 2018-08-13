## Aula 10 - Mon Oct 23 BRST 2017

## 4) Heurística de Busca Local

Os algoritmos de busca vistos até agora foram projetados para explorar sistematicamente espaços de busca. Esse carater sistemático é alcançado mantendo-se um ou mais caminhos na memória. Isso opera enquanto um objetivo não é encontrado, cujo caminho também constitui a solução para o problema.

No entanto, em muitos problemas, o caminho até o objetivo é irrelevante, por exemplo, para: **projeto de circuitos integrados, instalaçoes industriais, escalonamento de jornada de trabalho, otimização em telecomunicações, roteamento de veículos**, entre outros.

Assim, com a não consideração pelo caminho, os algoritmos de busca local são soluções interessantes, pois operam usando um único estado atual, considerando apenas os seus vizinhos.

As duas grandes vantagens dessa classe de algoritmos são:

 - Usar pouca memória;
 - Encontram soluções razoáveis em grandes (infinitos) espaços de estados (algoritmos sistemáticos são inadequados).

Além de encontrar objetivos, esta classe de algoritmos é útil para resolver problemas de otimização nos quais o objetivo é encontrar o melhor estado a partir de uma função objetivo.

Na busca local é interessante entender a **topologia de espaço de estados**

> img função objetivo


## 4.1) Busca de subida de encosta

Trata-se de um algoritmo com um laço de repetição que executa de maneira contínua no sentido do valor crescente, isto é, encosta acima. O algoritmo termina quando alcança um pico em que nenhum visinho tem valor mais alto. O algoritmo nao mantem uma arvore de busca C, assim, a estrutura de dados do nó atual só precisa registrar o estado e o valor da função objetivo. A busca da subida da encosta não examina antecipadamente valores de estados além dos vizinhos imediatos do estado corrente.

```
função Subida-de-encosta (problema) retorna um estado que é maximo local

	corrente <- criar-no(estado-inicial[problema])
	repita
		vizinho <- um sucessor de corrente com valor mais alto
		se valor[vizinho] < valor[corrente] então retornar estado[corrente]
	corrente <- vizinho

```

Infelizmente, a subida de encosta pode ser paralizada pelas seguinte razoes:

 - **Maximos locais**: o maximo local é um pico mais alto que cada um dos seus vizinhos, embora seja mais baixo que o maximo local. Os algoritmos de subida de encosta que alcançarem a vizinhança de um maximo local serão deslocados para cima, em direção ao pico, porém, esse pico será o seu limitador.
 - **Cordilheiras**: Cordilheiras resultam em uma sequencia de maximos locais o que torna dicifil a navegação para algoritmos mais ambiciosos.
 - **Platos**: Trata-se de uma area plana de topologia de espaço de estados. Ele pode ser um maximo local plano, a partir do qual não existe nenhuma saída encosta acima ou uma planice, a partir da qual é possível progredir, conforme visto anteriormente no gráfico. Uma busca de subida de encosta talvez se **perca** no platô.

Criaram-se variantes de subida de encosta. A **subida de encosta estocastica** escolhe de forma aleatoria movimentos encosta acima. A probabilidade de seleção pode variar com a declividade do movimento encosta acima. Em geral, isso converge mais lentamente em subidas ingremes. A seguir serão tratadas duas variantes de subida de encosta:

### A) Subida de encosta pela primeira escolha

Implementa a subida de encosta estocastica gerando sucessores ao acaso, até ser gerado um sucessor melhor que o estado corrente. Essa é uma boa estratégia quando um estado tem muitos sucessores.

### B) Subida de encosta com reinicio aleatório

Com frequencia, os algoritmos das classes apresentadas anteriormente sofrem com a busca por objetivo, pois as vezes, ficam presos em máximos locais. Para isso, esta classe aleatória utiliza-se da ideia da geração de estados iniciais aleatorios de modo a direcionar para um objetivo, quando há uma estabilização em um máximo local.

## 4.2) Têmpera simulada

Um algoritmo de subida de encosta que nunca faz monimento encosta a baixo sem dpuvida é incompleto e pode ficar preso em um maximo local. Também, mover de maneira puramente aleatoria paara um conjunto de estados, pode ser ineficiente. Assim, combinar essas duas caracteristicas é o que faz a **Têmpera simulada**.

Essa estratégia tem por objetivo tratar a minimização do custo por descida gradiente (descer encosta). É baseado no processo de temperar e endurecer metais e vidros na metalurgica, aquecendoo-os até altas temperaturas e esfriando-os gradualmente.

O laço de repetição mais interno do algoritmo de têmpera simulada, em vez de escolher o melhor movimento, como faz a subida de encosta, ele escolhe um movimento aleatório. Se o movimento melhorar a situação, ele será sempre aceito. Caso contrário, o algoritmo aceitará o movimento com alguma probabilidade menor que 1. A probabilidade decresce exponencialmente com um movimento ruim (delta E piora). A probabilidade também decresce a medida que a temperatura T se reduz: movimentos ruins tem probabilidade maior de serem permitidos no inicio, quando T estiver alto está probabilidade é mais improvável. Se o escalonamento diminuir T com lentidão suficiente, o algoritmo encontrará um valor ótimo global com probabilidade proxima de 1.
