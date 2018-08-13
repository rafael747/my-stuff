## Aula 21/08/17

### 2) Agentes Inteligentes

Até então, o que se viu foi a conceituação dos agentes racionais, que são parte fundamentais para que os sistemas possam ser classificados como inteligentes. No entanto, uma abordagem mais concreta será apresentada, no contexto do seu ambiente.

### 2.1) Classificação de agentes e ambientes

Um agente é tudo o que pode ser considerado capaz de perceber seu ambiente por meio de sensores e de agir sobre esse ambiente por intermédio de atuadores.

Como exemplo, tem-se:

```
 ______________                  ___
|Agente|       |  Percepções    | A | 
|______|     <----------------- | M |
|              |                | B |
|    Sensores  |                | I |
|     __|__    |                | E |
|    |__?__|   |                | N |
|       |      |    AÇÕES       | T |
|   Atuadores --------------->  | E |
|______________|                |___| 

```

EX: 


 -  Agente Humano
   - Olhos (sensor)
   - Ouvidos (sensor)
   - Mãos (atuador)
   - Pernas (atuador)

 - Agente Robótico
   - Câmeras (sensor)
   - Detector Infra (sensor)
   - Motores (atuadores)

 - Agente de Software
   - Sequencia de teclas digitadas (sensores)
   - Arquivos
   - Pacotes
   - Tela (atuadores)
   - Arquivos
   - Pacotes 


Além disso, há a percepção para fazer referencia às entrada perceptivas do agente em um dado instante. A sequencia de percepções do agente é a historia completa de tudo que o agente percebeu. Do ponto de vista matemático, pode-se afirmar que o comportamento do agente é descrito pela função do agente que mapeia qualquer sequencia de percepções específicas para uma ação.

De modo a ilustrar o mapeamento matematico, pode-se utilizar uma tabela. Nesse caso, considere o exemplo a seguir:


```
 ____________   ___________
|A           | |B          |
|     _/_    | |           |
|    |___|   | |           |
|            | |           |
|  ~ ~ ~     | |  ~ ~ ~    |
|   ~ ~ ~    | |   ~ ~ ~   |
|____________| |___________|
 
```

 - Ações
   - Mover-se para a direita;
   - Mover-se para a esquerda;
   - Aspirar;
   - Não fazer nada.

A Função agente pode: se o quadrado estiver sujo, então aspirar, caso contrario mover-se para o outro quadrado.


```
 ____________________________________
| Sequencia de Percepções |   Ação   |
|-------------------------|----------|
|  [A, Limpo]             | Direita  |
|  [A, Sujo]              | Aspirar  |
|  [B, Limpo]             | Esquerda |
|  [B, Sujo]              | Aspirar  |
|  [A, Limpo],[A, Limpo]  | Direita  |
|  [A, Limpo],[A, Sujo]   | Aspirar  |
|  .............          |  ......  |
|_________________________|__________|


Algoritmo,

Função AGENTE-ASPIRADOR-REATIVO([posição,situação]) retorna uma ação
	se situação = sujo então retorna Aspirar
	senão se posição = A entao retorna Direita
	senão se posição = B entao retorna Esquerda


```

### 2.2) Racionalidade

Um agente racional é aquele que faz tudo certo. Em termos conceituais:

 - Toda entrada na tabela corresponde à função do agente é preenchida de forma correta.

A corretudo está relacionada à uma ação cumprir o seu papel de forma desejável. Assim, busca-se a a captura de uma medida de desempenho que avalia qualquer sequencia dada dos estados do ambiente.
A definição do que é racional em qualquer instante dado depende de quatro fatores:

 - A medida de desempenho que define o critério de suceso;
 - Conhecimento prévio que o agente tem do ambiente;
 - As ações que o agente pode executar;
 - A sequencia de percepção dos agente até o momento.

Assim, a definição formal de um agente racional:

**Para cada sequencia de percepção possível, um agente racional deve selecionar uma ação que se espera venha a maximizar sua medida de dezempenho, dada a evidencia fornecida pela sequencia de percepção e por qualquer conhecimento interno do agente**



