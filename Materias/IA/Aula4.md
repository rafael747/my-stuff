## Aula 28/08

### 2.3) Natureza dos Ambientes

O passo, agora, é pensar na estratégia para a construção de agentes racionais. No entanto, ainda falta conceituar os ambientes de tarefas, que são os pontos em que os agentes atuarão para resolver.

#### A) Ambiente de Tarefa

Todos os elementos vistos anteriormente como medidas desempenho, ambiente, atuadores e sensores serão agrupados em uma descrição chamada PEAS (performance, enviroment, actuators, sensors). Para o processo de um agente, a primeira etapa é especificar o ambiente de forma tão completa quanto possível.

#### B) Propriedade de ambientes de tarefa

Existe uma variedade de ambientes de tarefas que podem surgir em IA. No entanto, esses ambientes devem ficar divididosem categorias, para que haja um projeto apropriado de agentes e a sua aplicação correta. As categorias se baseiam em algumas dimensões, as quais são:

 - Completamenteobservável x parcialmente

Observável: se os sensores permitem o acesso ao estado completo do ambiente, este é observável. Um ambiente parcialmente observável pode ser classificado pela ocorrencia de ruídos e medidas imprecisas. A ausencia de sensores classificam o ambiente como inobservável.

 - Agente único x multiagente

Um agente atuando sempre de maneira isolada, classifica-se como agente único. Se existe mais de uma interação, entao é multiagente. Esses podem ser competitivos ou cooperativos.

 - Episótico x Sequencial

Em um ambiente episótico, a experiencia do agente é dividida em episódios atômicos (ação única). No contexto sequencial, uma decisão em um determinado momento afeta decisões futuras.

 - Estático x Dinâmico

Se ambiente puder ser alterar enquanto um agente está deliberando, então ele é dinâmico. Caso contrário, ele é estático. Tudo que é estático é mais fácil de manipular.

 - Discreto x Contínuo

 A distinção desses dois tipos de ambiente aplica-se ao modo como o tempo é tratado pelo ambiente.

 - Conhecido x Desconhecido

Esta dimensão refere-se mais à base de conhecimento do agente. Em um ambiente conhecido, todas as possibilidades são fornecidas. Em um ambiente desconhecido, o agente deverá descobrir.

### 2.4) Estrutura de Agentes

Com os conhecimentos anteriormente apresentados, agora é possível projetar o programa do agente, o qual depende de um dispositivo de computação para executar. Assim, um agente:

    Agente = Arquitetura + programa

Os programas de agentes possuem, basicamnete, a mesma estrutura: **receber a percepção atual como entrada de dados** e **devolver uma açãopara os atuadores**. Assim, um programa de agentes pode ser:


```
Função agente_dirigido_por_tabela (percepção) retorna Uma_ação
	variaveis estáticas: percepção, sequencia, tabela, ação
	ação <- acessar(percepção, tabela)
	retornar(ação)
```

Um elemento auxiliar ai programa é a construção de uma tabela com as possibilidades. No entanto, o uso de tabelas tem sido desencorajado, devido ao tamanho que essas tabelas passaram a apresentar. Assim, o uso apenas de programas tem se mostrado ideal.

Uma atenção especial passou a ser voltada para os programas dos agentes, dividindo-os em **quatro** tipos basicos:

 - Agentes reativos simples;
 - Agentes reativos baseados em modelo;
 - Agentes baseados em objetivos;
 - Agentes baseados na utilidade.

#### A) Agentes Reativos Simples

Este trata-se do tipo mais simples de agente. Sua percepção para seleção de ações depende apenas da percepção atual, ignorando o restante do historico de percepções.
Comportamentos reativos simples também ocorrem em ambientes complexos, mesmo que muitas ações (decisões) precisem ser tomadas.
Como exemplo de sua simplicidade, pode-se considerar a tomada de decisão, como no caso do aspirador de pó visto anteriormente. Naquele caso, a decisao de ir para um comodo ou outrose baseava apenas na condição atual do comodo em que o aspirador se encontrava. Em uma situação mais complexa, pode-se considerar, por exemplo, um motorista de um veículo em que, a sua frente, encontra-se um carro em potencial frenagem. A decisão por frenar ou não vem da seguinte consideração: "A luz de freio está acesa, e o carro está se aproximando, portanto, ocorre uma frenagem".
Assim, o diagrama de blocos que descreve adequadamente o agente reativo simples encontra-se a seguir:


```
 ________________                  ___
|Agente|         |  Percepções    | A |
|______| Sensores|    <---------- | M |
|                |                | B |
|Qual a aparencia|                | I |
|     do mundo   |                | E |
|Que ação executar|     |                | N |
|       |        |    AÇÕES       | T |
|   Atuadores   --------------->  | E |
|________________|                |___|

```

Os agentes reativos simples tem uma propriedade de serem consideralmente simples, porém se caracterizam por ter inteligencia limitada. Ele operará apenas se tiver a capacidade da percepção atual, ou seja, o ambiente deve ser completamente observável, o que se não for respeitado pode causar diversas dificuldades.
Dessa forma, este tipo de agente não se adequa bem à componentes com grau de aleatoriedade qualquer.

#### B) Agentes Reativos Baseados em modelos

O modo mais efetivo de lidar com a possibilidade de observação parcial é o agente monitorar a parte que ele nao consegue visualizar de imediato. Assim, será necessário o agente manter algum tipo de **estado interno** que dependa do historico de percepções e reflita pelo menos alguns dos aspectos do estado atual que não foram observados.

Atualização dessas informações internas de estado à medida que o tempo passsa exige que dois tipos de conhecimento sejam codificados no programa do agente.

 1. São necessárias informações sobre o modo como o contexto evolui independentemente do agente;
 2. Em segundo lugar, são necessárias informações sobre como as ações do proprio agente afetam o contexo. Esse conhecimento do modo de operação desse agente e de como tudo do contexto dele funciona é chamado de **modelo de mundo** e um agente deste modelo é denominado **agente baseado em modelo**.

