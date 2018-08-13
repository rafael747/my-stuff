
------
> Aula do dia 4 de abril de 2016

### Escalonamento em sistemas em lotes 

 - FCFS (first come first served)
Trata-se do algoritmo de escalonamento mais simples não premptivo. Nesse algoritmo, a ucp e atribuida aos processos na ordem em que eles requisitam. Basicamente, há uma fila única de processos **prontos**. Agrande vantagem desse algoritmo é que ele é **fácil de entender e programar**. Infelizmente, pode causas grandes filas de processos curtos.

 - SJF (Shortest job first)
Outro algoritmo de sistem em lotes, não premptivo. Quando existem várias tarefas igualmente importantes em uma fila de entrada à espera para serem iniciadas, o escalonador escolhe a tafera de tempo **mais curto primeiro**.

### Escalonamento em sistemas interativos

 - Round-Robin (chaveamento circular)
Trata-se de um dos algorimos **mais simples e justos**. A casa processo é atribuido um intervalo de tempo (quantum), no qual ele é permitido executar. Ao final do quantum, se o processo ainda estiver executando, a UCP sofrerá preempção e será dada a outro processo.

 - Por prioridades
Quando se consideram fatores externoos atuando nos processos é atribuída uma prioridade, e o processo executável com prioridade mais alta é permitido executar.

 - Filas de Prioridades múltiplas
Trata-se da criação de um escalonamento por multiplas filas, com prioridades diferentes. Todos os processos de uma fila **tem a mesma prioridade**. Assim as filas são executadas em sua ordem de prioridade e os processos em cada fila, são executado por sua ordem de chegada.

 
-----

## Gerenciamento de Memória

A memória principal (RAM) é um recurso importante que deve ser gerenciado com muito cuidado. Embora os computadores atuais possuirem memórias de grande porte, os programas tornaram-se maiores muito mais rapidamente do que as memórias.
Assim, o conceito de hierarquia de mamoria tornou-se essencial, bem como se estabelecer um bom processo de gerenciamento de memória. Basicamente, as memórias foram organizadas a partir de modelos bem conhecidos:

```
          ___________________
         |                   |
      A) |programa do usuário|
         |-------------------|
         |     SO em RAM     |
         |___________________|

          ___________________
         |                   |
      B) |     SO em ROM     |
         |-------------------|
         |programa do usuário|
         |___________________|
        
           _____________________________
          |                             |
       C) |Drivers de dispositivo em ROM|
          |-----------------------------|
          |     Programa do Usuário     |
          |-----------------------------|
          |          SO em RAM          |
          |_____________________________|

```

### Espaço de Endereçamento

Para que múltiplas aplicações estejam na memória simultaneamente sem a interferência muntua, dois problemas devem ser resolvidos: **Proteção** e **Realocação**.
Uma solução mais intereçante é projetar uma **abstração** para a memória: O **espaço de endereçamento**. Assim como o conceito de processo cria um tipo de UCP abstrata para executar programas, ** o espaço de endereçamento** cria um tipo de memória abstrata para abriga-los. Um espaço de endereçamento é um conjunto de endereços que um processo pode usar para endereçar a memória. Cada processo tem o seu próprio espaço de endereçamento, independente dos que pertencem a outros processos.


### Troca de Memória

Se a memória física do computador for grande o suficiente para armazenar todos os processos, os processos comentados até agora bastarão. No entanto, na prática, a quantidade total de RAM necessária para todos os processos é frequentemente muito maior do que a memória pode comportar.
Dois métodos gerais para lidar com a sobrecarga de memória têm sido desenvolvidos com o passar dos anos. A estratégia mais simples, denominada troca de processos (swapping), consiste trazer, em sua totalidade, cada processo para a memória, executá-lo durante um certo tempo, e, então, devolvê-lo ao disco.
A outra estratégia, denominada memória virtual, permite que programas sejam executados mesmo que estejam apenas parcialmente carregados na memória pricipal.
Quando as trocas de processos deixam muitos espaços vazios na memória, é possivel combiná-los todos em um único **espaço contíguo** de memória, movendo-os o maximo possivel, para os **endereços mais baixos**. Essa técnica é denominada **compactação de memória**. Ela geralmente não é usada em virtude do tempo de processamento necessario.


> aula 18/04/16


### Memória Virtual

O problema de programas maiores que a memória está presente desde o início da computação, ainda que em áreas limitadas, como ciência e engenharia. Uma solução adotada inicialmente na década de 60 foi a **divisão do programa** em módulos, denominados **sobreposições (overlays)**. Quando um programa era inicializado, tudo o que era carregado na memória era o gerenciador de sobreposições, que imediatamente carregava e executava a sobreposição.
A divisão de programas grandes em módulos menores era um trabalho **lento**, **efadonho** e **propenso a erros**. Assim, projetou-se uma maneira de se fazer isso **automaticamente**.
Assim, concebeu-se um método que ficou conhecido como **memória virtual**. A idéia basica por trás da memória virtual é que cada programa tem o seu próprio espaço de endereçamento, que é dividido em blocos chamados **páginas**. Cada página e uma série contínua de endereços. Essaas páginas são mapeadas na memória física, mas nem todas precisam estar na memória física para executar o programa. Quando o programa referencia uma parte do seu espaço de endereçamento que está na memória fisica, o hardware executa o mapeamento necessário dinâmicamente. Quando o programa referencia uma parte de seu espaço de endereçamento que **não** está em sua memória física, o sistema operácional é alertado para obter a parte que falta e reexecutar a instrução que falhou.


## Algorítmo de Substituição de Páginas

Quando ocorre uma falta de página, o sistema operácional precisa escolher uma página a ser removida da memória para liberar espaço para uma nova página a ser trazida para a memória. Se a página a ser removida tiver sido modificada enquanto está na memória, ela **deverá ser reescrita** no disco com o proposito de **atualizar** a cópia virtual **lá existente**. Se, contudo, a página **não tiver sido modificada**, a cópia em disco já estará atualizada, e assim, não é necessário reescreveê-la.

### Algorítmo ótimo de substituição

O melhor dos algoritmos de substituição de página é fácil de descrever, mas impossível de implementar. Ele funciona da seguinte maneira: no momento em que ocorre uma falta de página, existe um determinado conjunto de páginas na sua memória. Uma delas será referenciada na próxima instrução, ou seja, trata-se da mesma página que contém a instrução que gerou a falta de página.
O único problema com esse algoritmo é que ele é irrealizável. Na ocorrência de uma falta de página o sistema operacional não tem como saber quando cada uma das páginas será referenciada novamente.

### Algorítmo NRU (not recently used)

O algoritmo NRU remove aleatoriamente uma  página da classe de ordem mais baixa que não esteja vazia. Está implicito nesse algoritmo que é **melhor remover uma página modificada mas não referenciada**, a pelo menos um clock de relógio, do que **uma página não modificada** que está sendo intensamente referenciada.

### Algoritmo em Fila

O algoritmo de substituição de página **primeiro a entrar, primeiro a sair (first-IN, first-out- FIFO)** é um algoritmo de baixo custo.
O sistema operacional mantem uma lista de todas as páginas atualmente na memória com a **pagina mais antiga** na cabeça da lista e a página que chegou mais recentemente situada na fina desta lista. Na ocorrencia de uma falta de página, a **primeira página da lista é removida** e a nova página é adicionada no final da lista.
Existe tambem a variação dele que é a lista lifo (last-in, first-out), porém é muito ineficiente.

### Algorítmo de substituição da página usada menos recentemente (LPU- Least recently used)

Uma boa aproximação do algoritmo ótimo de substituição de página é baseado na observação de que as páginas muito utilizadas nas ultimas instruções, provavelmente serão muito utilizadas novamente nas próximas instruções.
Ao contrário, páginas que nao estão sendo utilizadas por um **londo período de tempo** provavelmente permanecerão inutilizadas por muito tempo. Esta ideia sugere que quando ocorrer uma falta de página, **elimine a páginanão utilizada pelo período de tempo mais longo**.

> aula 25/04/16

## Sistemas de Arquivos

Todas as aplicações precisam armazenar e recuperar informações. Enquanto estiver executando, um processo pode executar uma **quantidade limitada** de informações dentro do seu próprio espaço de endereçamento.
Contudo, a capacidade de armazenamento está restrita ao tamanho do espaço de endereçamento virtual. Para algumas aplicações, esse **tamanho é adequado**, mas, para outras, é **preciso mais** (grandes bases de dados).
Um outro problema enfrentado em manter a informação dentro do espaço de endereçamento do processo é que, quando o **processo termina**, a informação é **perdida**.
Além disso, um outro problema é que muitas vezes é necessário que multiplos **processos tenham acesso à informação** (ou parte dela) ao **mesmo tempo**. Para isso, é necessário que a informação seja independente de qualquer processo.
Dessa forma, existem três requisitos essenciais para o armazenamento de informaçõesa longo prazo:

 - A possibilidade de armazenamento de uma quantidade muito grande de informação.
 - A informação deve sobreviver ao término do processo que a utiliza.
 - Multiplos processos têm de ser capazes de acessar a informação concorrentemente.

Para isso, a estrutura de armazenamento mais indicada é o **arquivo**.
**Arquivos** são **unidades lógicas** de informação criadas por processos. Em geral, um disco contém milhares de arquivos, um independente do outro. Na verdade, os arquivos são uma espécie de **espaço de endereçamento**, mas eles são usados para **modelar o disco** e não a memória RAM.


Arquivos são gerenciados pelo sistema operacional. O modo como são **estruturados, nomeados, acessados, usados, protegidos e implementados** são um dos principais tópicos de um projeto de sistema operacional. De modo geral, essa parte do sistema operacional que trata dos arquivos é conhecida como **sistema de arquivos**.

### Estrutura de arquivos

Os arquivos podem ser estruturados de várias maneiras. No entanto, três possibilidades são muito comuns.

A) Uma sequencia estruturada de bytes. De fato, o sistema operacional não sabe o que o arquivo contêm ou simplesmente são se interessa por isso. Tudo que é **manipulado são bytes**. Ter o sistema tratando arquivos como nada mais do que sequencia de bytes **oferece máxima flexibilidade**. Os programa sde usuários podem por qualquer coisa que queiram em seus arquivos e chamá-los pelo nome que lhes convier

```
         |byte|byte|....|byte|
```
B) O primeiro passo em uma potencial estruturação se dá no **modelo de sequencia de registros**. Nesse modelo, um arquivo é uma **sequencia de registros de tamanho fixo**, cada um com alguma estrutura interna. A **idéia central** de ter um arquivo como uma sequencia de registros é que a **operação de leitura retorna um registro** e a **operação de escrita sobrepoe** ou **anexa um registro**.

```
           |  registro  |  registro  | ...... |  registro  |
```

C) Trata-se de uma organização em que um arquivo é constituido por **uma arvore de registros**, não necessariamente todos do mesmo tamanho, cada um contendo um **campo-chave** em **uma posição fixa** no registro. A arore é **ordenada pelo campo chave** para que se busque mais **rapidamente** por uma **chave** especifica. 

```
           OOOOO
          /  |  \
        OOO OOO OOO
        / \  |    \
       OO  O OO   OOO 
 
```

------------------

> 02/05/16

## Implementação do Sistema de Arquivos

Os sistemas de arquivos são armazenados em **disco**. A maioria dos discos é dividida em uma ou mais partições, com **sistemas de arquivos independentes** em cada partição. O **setor 0** do disco é chamado de **MBR (Master Boot Record)** e é utilizado na inicialização do sistema computacional. O **Fim da MBR** contém uma tabela de partição, que indica os endereços **iniciais** e **finais** de cada **partição**.
A primeira coisa que o programa do **MBR** faz é localizar a partição ativa, ler o seu primeiro bloco, chamado de bloco de inicialização e executá-lo. A partir dai, o SO é carregado.

### Manutenção do sistema de arquivos

O ponto mais importante a ser considerado no sitema de arquivos é a **manutenção** de quais blocos dos discos estão relacionados a quais arquivos.  

 - Alocação Contínua
O esquema mais simples de alocação é armazenar cada arquivo em blocos **contínuos** e disco. Por exemplo, em um disco com blocos de 1KB, um arquivo de 50KB seria alocado em *50 blocos consecutivos**.
Algumas vantagens podem ser verificadas com esse método. A primeira delas é a facilidade de se implementar, visto que o controle sobre os blocos de um arquivo está reduzido a lembrar de **dois** números: **O endereço em disco do primeiro bloco** e ** o número de blocos**. Uma segunda vantagem, é o desempenho de leitura, pois todo o arquivo pode ser lido do disco em uma **única operação**.
Infelizmente, a alocação contínua também tem um ponto fraco **significativo**: com o passar do tempo, o disco fica **fragmentado**. Esses milhares (milhoes) de lacunas geradas **degradam** o desempenho em termos de tempo de acesso.

 - Alocação por Lista Encadeada
O segundo método para armazenar arquivos é mantê-los, cada um, como uma lista encadeada de blocos de disco.

```

       arquivo:       |bloco 1| -> |bloco 2| -> |bloco 3|
       bloco físico:      4            7            2
```


A primeira palavra de cada bloco é usada como ponteiro para o próximo. Nesse método, diferentemente da alocação contínua, todo bloco de sico pode ser utilizado. Nenhum espaço é perdido pela fragmentação. É necessário manter apenas o endereço para o primeiro bloco.
Por outro lado, embora a leitura sequencial seja direta, o acesso aleatório é extremamente lento.

 - I-Node
Esse método consiste em associar a cada arquivo uma estrutura chamada **i-node**, que relaciona os atributos e os endereços em disco dos blocos de arquivo.

```
          ______________________
         | Atributos do Arquivo |
         | Endereço do bloco 0  |
         | Endereço do bloco 1  |
         | Endereço do bloco 2  |
         |         ....         |
         | Endereço do bloco N  |
         | End. bloco ponteiros | -> bloco de disco com endereços adicionais
         |______________________|
        
```

A grande vantagem do I-node sobre os arquivos encadeados que usam uma tabela de mamória é que o i-node só precisa estar na memoria quando o arquivo correspondente é aberto. Na tabela, pode-se ter que carregar todas as informações que estão encadeadas.


## Entrada e Saída (E/S - I/O)

Além de oferecer abstrações como processos, espaços de endereçamento e arquivos, o SO também controla todos os dispositivos de E/E de um sistema computacional. Ele devve emitir **comandos para os dispositivos**, **interceptar interrupções** e **tratar os erros**. Deve também fornecer uma interface entre os dispositivos e o restante do sistema que seja simples e facil de usar. O código de E/S representa uma fração significante de todo o SO.

 - Dispositivos de E/S
Os dispositivos de E/S podem ser, de modo genêrico, divididos em duas categorias: **Dispositivos de Blocos** e ** Dispositivos de Caractere**.
Um dispositivo de bloco é aquele que armazena informações de blocos de tamanho fixo, cada um com seu próprio endereço. A propriedade essencial de uma dispositivo de blocos é que cada bloco pode ser lido ou escrito independentemente de todos os outros. Discos Rígidos, CD-ROM e  Pendrives são alguns dos exemplos.
Outro dispositivo de E/S é o dispositivo de caractere, o qual **envia** ou **recebe** um **fluxo** de **caracteres**, sem considerar qualquer estrutura de blocos. Ele não é endereçável e não dispoe de qualquer operação de posicionamento. Impressoras, internaces de rede e mouses são exemplos desses dispositivos.

### Controle de Entrada e Saida via Software

Estabelecimento dos controles de E/S via software no SO. Este controle é necessário para garantir a **independencia** dos **dispositivos**.

 - E/S Programada
Trata-se do método mais simples de se fazer E/S. A UCP realiza todo o trabalho , o que degrada a eficiência.
O aspecto principal da E/S programada é que após a saída de uma informação, a UCP continuamente verifica se o dispositio está pronto para aceitar outro. Este comportamento é chamado de **espera ocupada (Busy Waiting)**.

 - E/S por Interrupção
Outro modo de permitir que a UCP faça outra coisa enquanto espera a operação de E/S tornar-se pronta é usar **interrupções**. Quando é feita uma chamada de sistema para E/S, o buffer é copiado para o espaço de núcleo do SO. Nesse ponto, a UCP chama o escalonador e outro processo é executado. O processo inicial que solicitou E/S é bloqueado, até que a solicitação de E/S seja finalizada. A partir dai, o dispositivo de E/S **interrompe** a UCP, para dar sequencia nas operações.

 - E/S via DMA (Direct memory access)
Uma desvantagem de mecanismo de E/S por interrupção é a ocorrencia de interrupções frequentes. Interrupções levam tempo, de modo que esse esquema desperdiça uma certa quantidade de tempo de UCP. Uma solução é usar o **acesso direto à memória (dma)**. A ideia é fazer um controlador **alimentar** os dispositivos de E/S sem ocupar a UCP. Na verdade, é um tipo de E/S programada, mas quem fica ocupado é apenas o controlador de DMA do dispositivo. Essa estratégia requer um hardware especial em cada dispositivo de E/S.

------

> 09-05-16

## Sistemas distribuídos – introdução

 -  Histórico

Sistemas de computação estão em constante evolução.
Entre as décadas de 40 e 80 os computadores eram de grande porte e caros.
Subutilização dos computadores, pois funcionavam de maneira independente.
A partir da década de 80 os computadores passaram a ter grande capacidade de processamento e interligados por redes de alta velocidade.
Portanto, um sistema distribuído (SD) pode ser definido como: um conjunto de computadores independentes que se apresenta a seus usuários como um sistema único e coerente.

 - Características e organização de um SD

Consiste de componentes autônomos.
Os usuários (pessoas ou programas) entendem estar tratando com um único sistema. Com isso, surge a ideia de colaboração.
Os elementos que compõem um SD podem ser heterogêneos.
Todos os procedimentos devem ser transparentes no usuário.
Além de garantir uma interação de maneira consistente uniforme, deve-se manter a capacidade de expansão da sua escala. Os usuários não podem perceber potenciais avariações no sistema.
De modo a suportar a característica de heterogeneidade de um SD, uma camada de software deve ser implementada. Esta camada se situa entre a camada de alto nível (usuário e aplicações) e a de baixo nível (SO e comunicação). A esta camada denomina-se middleware.

> imagem middleware



### Metas para um SO

 - Facilidade de acesso à recursos
 - Oculta o fato da distribuição dos recursos na rede
 - Deve ser aberto
 - Deve ser expandido
 - Transparência:
    - Acesso: Oculta direfenças na representação de dados e no modo de acesso à um recurso.
    - Localização: Oculta o lugar em que um recurso está localizado.
    - Migração: Oculta que um recurso pode ser movido para outra localização.
    - Relocação: Oculta um recurso que pode ser movido para uma outra localização enquanto em uso.
    - Replicação: Oculta que um recurso é replicado
    - Concorrência: Oculta que um recurso pode ser compartilhado por diversos usuários concorrentes.


 - Abertura
    - Interfaces de operação
    - Garantir a interoperabilidade e a portabilidade
    - Garantir que o SD seja extensível

 - Escalabilidade 
    - Facilidade de adicionar mais recursos e usuários
    - Facilidade de administração do SD
    - Limitações da Escalabilidade:
	- Serviços centralizados: Um único servidor para todos os usuários.
	- Dados centralizados: Um único local de acesso aos dados.
	- Algorítmos centralizados: Dependem de uma análise de todas as informações. 

 - Confiabilidade
    - A rede é confiável?
    - A rede é segura?
    - A rede é homogênea?
    - A topologia não muda?
    - A latência é zero?
    - A largura da banda é infinita?
    - O custo de transporte é zero?
    - Há só um administrador?

## Tipos de SDs

###Cluster:

 - Homogênidade
 - Cada nó executa o mesmo SO
 - Rede local de alta velocidade
 - Único programa executando em paralelo em várias maquinas

```
 
                Nó Mestre           Nó Comp1        Nó Comp2
              ______________      ___________      ___________
             | Aplicação de |    |Comp. da ap|    |Comp. da ap|
             | gerênciamento|    | paralela  |    | paralela  |
             |______________|    |___________|    |___________|     ..........
             | Bibliotecas  |    | SO local  |    | SO local  |
             |______________|    |___________|    |___________|
             |   SO local   |          |                |
             |______________|          |                |
                  |    |               |                |
          ________|    |_______________|________________|
            Rede            Rede de alta velocidade
           Externa
          
```


###Grade:

 - Recursos Heterogêneos
 - Divisão em camadas
    - Camade de cenectividade: Protocolos de comunicação.
    - Camada de recursos: Gerenciamento de recursos.
    - Camada coletiva: Gerencia o acesso aos múltiplos recursos.
    - Camada de aplicação: Gerencia aplicações.

```
               _____________
              | Aplicações  |
              |_____________|
                     |
             ________|_______
            |Camada coletida |
            |________________|
              |            |
      ________|_____    ___|______
     |  Camada de  |   |Camada de |
     |conectividade|   | Recursos |
     |_____________|   |__________|
                |         |
              __|_________|__
             | Camada  Base  |
             |_______________|
```

---------
> Aula 16-05-16

---------

## Arquitetura de SDs

 - Os SDs são muitas vezes, complexos sistemas de software.
 - Ficam espalhados por várias máquinas.
 - Os SDs devem ser organizados adequadamnte: **software e hardware**.
 - Grande parte desta organização acontece em **nível de software**.
 - Esta organização se baseia em uma **arquitetura de software**.
 - A arquitetura apresenta como os componentes de software são **organizados** e como eles devem **interagir**.

### Estilos arquitetônicos

 - Adotar uma arquitetura é crucial para o desenolvimento de grandes sistemas.

 - **Estilo arquitetônico**: como os **componentes** se conectam, trocam dados  e como sao configurados.
 - **Componente**: Unidade modular com interfaces requeridas e fornecidas bem definidas que é substituível de seu ambiente.
 - **Conector**: Mecanismo que faz a medição da comunicação ou da cooperação entre os componentes. Pode ser formado por: **chamadas a procedimentos remotos, passagem de mensagens ou fluxo de dados**.


### A junção de **componentes** e **conectores** permite a **criação** de vários **estilos arquitetônicos**:

 - Arquitetura em camadas.
 - Arquitetura baseada em objetos.
 - Arquitetura centrada em dados.
 - Arquitetura baseada em eventos.

-------

### Arquitetura em camadas

 - Os componentes são organizados em camadas.
 - Um componente da camada **Li** tem permição para chamar um componente da camada **Li-1**.
 - O contrário **não** é permitido.
 - O controle flui de camada em camada.

```

                       _____________
                      | Camada N    |
                      |_____________|
                          |       |       
                       _____________
                      | Camada N-1  |
                      |_____________|
        JJ Fluxo JJ        ......       ^^^ Fluxo de resposta ^^^
        Requisição     _____________
                      | Camada 2    |
                      |_____________|
                         |       |
                       _____________
                      | Camada 1    |
                      |_____________|

```

### Arquitetura baseada em Objetos

 - Cada objeto corresponde a um componente.
 - Os componentes são conectados por meio de uma chamada remota.
 - Todos os elementos se ajustam ao modelo cliente/servidos.
 - Esta arquitetura geralmente é utilizada em sistemas de grande porte.

```
           
           (Objeto) -----  (Objetos) ------ (Objeto)
              |    \          |              /
              |     \         |             /
              |      \       /             /
           (Objeto)   (Objeto) ------- (Objeto)     
            
```





### Arquitetura centrada em dados

 - Processos se comunicam por meio de um repositorio comum.
 - São arquiteturas muito importantes em projetos de SDs, devido a sua flexibilidade de **gestão dos dados**.
 - Trata de maneira muito eficiente o conjunto de **arquivos compartilhados**.

```
               _____________            ____________
              | Componente  |          | Componente |
               -------------            ------------
                      \                     /
                       \                   /
                        \                 /
                        ____________________
                       |  Espaço de dados   | 
                       |  Compartilhados    |
                        --------------------
```

### Arquitetura baseada em eventos

 - Processos se comunicam por propagação de eventos.
 - Baseado no mecanismo publicar/escrever.
 - O middleware garante que apenas os processos que subescrevam para os eventos receberam as suas publicações.
 - Os processos são desacoplados nessas arquiteturas.

```
                     ____________       ____________
                    | componente |     | componente |
            entrega |____________|     |____________|
          do evento  ______|__________________|________
                          
                      ....  Barramento de eventos .....
                     ___________________________________
                                   |   
                               ____________   Publicar
                              | componente |
                              |____________|
                     
```

------


## Organização dos SDs - Software


### Arquiteturas centralizadas: baseada no modelo cliente/servidor

```

                           Respera resul.
         Cliente  ----------------------------------------
                         \             /
                          \           /
                           \         / resposta
                Requisição  \       /
                             \     /
                              \   /
                               \ /
         Servidor  ------------------------------------------
                                                Tempo -->
```

 - Nessa organização, existem dois modelos
    - Camada de aplicação
    - Arquiteturas multidivididas




### Camada de Aplicação

 - A sua criação foi motivada por inúmeros problemas que eram enfrentados no modelo cliente/servidor puro.
 - Problemas na distinção do cliente e do servidor.
 - Divisão em **três níveis**:
    - Nível de interface com o usuário: contem tudo que é necessário para fazer interface diretamente com o usuário, como o gerenciamento de exibição.
    - Nível de processamento: contém, normalmente, as aplicações.
    - Nível de dados: Gerencia os dados propriamente ditos sobre os quais está sendo executada alguma ação.

```

              Nível de interface  |    Interface com o usuário  
                 de usuário       |
              --------------------|------------------------------
                  Nível de        | Gerador html, algoritmo de ordenação
               processamento      | Gerador de consultas
             ---------------------|------------------------------
               Nível de Dados     |  Banco de dados com paginas web

```

### Arquiteturas multidivididas

 - Criação da arquitetura de duas divisões.
 - Distribuem os programas presentes nas camadas de aplicação para máquinas diferentes.

```


            Interface     Interface     Interface    Interface
                                        Aplicação    Aplicação
            Interface     Aplicação
            Aplicação        BD         Aplicação       BD
                BD                          BD

```


## Arquiteturas Descentralizadas

1) Arquiteturas peer-to-peer estruturadas
2) Arquiteturas peer-to-peer não estruturadas
3) Gerenciamento de topologias de redes de sobreposição.

```


                                     Respera o resultado
        Interface   =====-------------------------------------------=========
          Usuário        \                                         /
                          \                                       /
                           \                                     / resposta
                Requisição  \                                   /
                             \                                 /
                              \                               /
                               \                             /
                                \       Respera dados       /
         Servidor de  -----------\====-----------------====/---------------
          aplicação                    \              /
                                        \            /
                                         \          / resposta
                              Requisição  \        /    dados
                                dados      \      /
                                            \    /
                                             \  /
           Servidor  -------------------------==---------------------------
        bando de dados                                                           
                        

```

### Arquiteturas Peer-to-Peer Estruturadas

 - Os nós são formados por processos.
 - Os enlaces são canais de comunicação viáveis.
 - Os processos só enviam mensagens por canais de comunicação disponíveis.
 - São modelos deterministicos.
 - Organizam os processos por meio de uma tabela hash distribuida (distributed hash table - DHT)
 - Os nós recebem chaves aleatórias, com identificadores de 128 ou 160 bits.
 - Implementa um mapeamento eficiente **chave-nó**.

### Arquiteturas Peer-to-Peer não estruturadas

 - São modeloas aleatórios (não deterministicos)
 - Cada nó mantém uma lista de vizinhos, contruída aleatoriamente.
 - O nó **inunda** a rede com um consulta quando precisa de um item de dado.
 - Itens de dados podem ser colocados aleatoriamente nos nós.

### Gerenciamento de topologia de redes de sobreposição

 - Considera a coexistência das arquiteturas peer-to-peer estruturadas e não estruturadas.

```

                         _______________      ______    Saída para nós
       Sobreposição     | Protocolo para|    /______    deterministicamente
        Estruturada     |  sobreposição |    \______    escolhidos
                         ---------------                                      
       ------------------------ ^ -----------------------------------------------
                                |                                        
                         _______|_________    ______    Saída para nós
       Sobreposição     | Protocolo para  |  /______    aleatoriamente
        Aleatória       | visão aleatoria |  \______    escolhidos
                         ------------------      
             
```


-----------------

> aula 2016-05-23

---------------


## Processos


 - Programa em execução.
 - Para o SO, o importante é analisar a questão do **gerenciamento e escalonamento**.
 - Para um SD a questão importante é o **multithreading**.

### Threads

 - Processos formam um bloco de construção de um SD.
 - A **granularidade** (divisão) do SO convencional não é suficiente para um SD.
 - O uso de multithreading como granularidade **mais fina** para o SD, **facilita** a construção de aplicações distribuídas.
 - Para executar programas, o SO cria vários processadores virtuais.
 - O SO tem uma tabela de processos\ que armazena: **valores de registradores da UCP**, **mapa de mamória**, **arquivos abertos**, **privilégios, entre outros.
 - Esta thread executa **uma porção de código**.
 - Além disso, a thread guarda informações minimas para **compartilhar** a UCP.

### Implementação de threads em SD

 - Criação e destruição de threads.
 - Operações de **sincronização** e **condição** sobre variáveis.
 - **Divisão** de **threads**: Em nível de **núcleo** e em **nível de usuário**.
 - A solução mais viável é a utilização de **Processos leves** (Lightweight Processes - LWP).


> img LWP


 - Executa no contexto de um único processo (pesado).
 - Todas as operações com threads não precisam de intervenção do núcleo.
 - Fornece um pacote de threads em nível de usuário, o qual pode ser compartilhado entre vários **LWPs**.
 - É atraente para um SD, pois permitem chamadas bloqueadas de um sistema sem bloquear o processo inteiro.
 - Facilitam muito para expressar comunicação na forma de manter multiplas conexões.


### Clientes Multithread

 - SDs que operam em redes de longas distâncias precisam esconder longos tempos de propagação.
 - Permitir a abertura de várias conexões simultaneas.
 - Pode estabelecer conexões com diferentes réplicas dos servidores, permitindo a transferencia paralela.

### Servidores Multithread

 - Explorar o paralelismo para obter alto desempenho.
 - Manter o desempenho com disponibilidade.
 - Aumentar a quantidade de requisições a serem processadas.

### Virtualização

 - Threads e processos podem ser vistos como um modo de fazer mais coisas ao mesmo tempo.
 - Em máquinas monoprocessadas, o **paralelismo** é algo **ilusório**..
 - Essa sensação na UCP é chamada de **virtualização de recursos**.
 - A **virtualização** tenta substituir a interface de operações, de modo a imitar o comportamento de outro sistema.

```
         ____________            __________________
        |  Programa  |          |     Programa     | 
        |------------|          |------------------|
        |Interface A |          |   Interface A    |
        |------------|          |------------------|
        |Hard/Soft do|          | Implementação de |
        |sistema A   |          |Imitação de A em B|
        |____________|          |------------------|
                                |   Interface B    |
                                |------------------|
                                | Hardware/Software|
                                | do sistema B     |
                                |__________________|
```


### Arquiteturas de máquinas virtuais, com quatro tipos de interfaces:

 - Interface entre hardware e software para qualquer programa.
 - Interface entre hardware e software para programas privilegiados.
 - Interface de chamadas de sistema.
 - Interface para as chamadas de bibliotecas, com as interfaces de aplicações de programação (API).


```
                _____________________
               | Aplicação           |
 Funções de <- |__________________   |
 Bibliotecas   | Biblioteca       |  |
               |_______________   |  |  -> Chamada de Sistemas
               |    Sistema    |  |  |
               |  Operacional  |  |  |
 Instruções <- |_______________|__|__| -> instruções Gerais
 privilegiadas |     Hardware        |
               |_____________________|

```




> primeira aula 30/05/2016


------


### Uso de Deamons

 - Criar um daemon em cada máquina para monitorar o acesso às portas.
 - Uma outra saída é a criação de um daemon para monitorar várias associadas a um serviço (inetd unix).


> img maquina cliente <-> Servidor


 - Servidor com estado:
    - Servidor pode ou não manter estado.
    - Pode haver mudança de estado sem o cliente ser avisado.
    - Manter o estado, muitas vezes, significa manter o serviço.

## Migração de código

 - Até então preocupou-se com a passagem de dados em um SD.
 - Em alguns casos há necessidade de **passagem de programas**.
 - Os algoritmos de distribuição de carga assumem um papel prioritário.
 - A idéia é processar os dados mais próximos de onde eles residem.
 - Auxilia na flexibilidade da contrução de aplicações distribuídas.
 - Um processo, nesse modelo, consiste de três segmentos:
   - **Segmentode código**: é a parte que contém o conjunto de instruções que compôem o programa que está em execução.
   - **Segmento de recursos**: comtém referências a recursos externos de que o processo necessita.
   - **Segmento de execução**: é usado para armazenar o estado de execução de um processo no momento em questão.

-----

> aula 06-06-2016

------


## Comunicação

### Fundamentos

 - A comunicação entre processos esta no coração de um SD.
 - A comunicação de um SD baseia-se na troca de mensagens.
 - A counicação por troca de mensagens é muito mais complexa do que por meio de primitivas de memória compartilhada.
 - Os SDs atuais são compostos por milhares ou milhões de processos em uma rede **não confiável**.
 - Desafio para o desenvolvimento de aplicações distribuídas.

### Protocolos

 - Toda a comunicação em um SD é baseada no conceito de protocolos.
 - Como a maioria das aplicações se utiliza da internet o TCP/IP é o protocolo mais adotado
 - Portanto, toda a comunicação obedece ao funcionamento do TCP/IP.

## Chamada de procedimento remoto (RPC)

 - **Procedimento chamador** e **procedimento chamado** executam em máquinas diferentes.
 - Executam em espaços de memória diferentes.
 - Necessário considerar **falha em nós comunicantes**.

 - Uma RPC deve ter:
  - count = read(fd, buf, nbytes)
  - fd -> indica um arquivo
  - buf -> vetor de caracteres no qual os dados são lidos.
  - nbytes -> inteiro que informa quantos bytes ler

### Etapas de uma RPC 

1. Procedimento cliente chama o apêndice de cliente do modo normal.
2. Apêndice de cliente constrói um mensagem e chama o SO local
3. O SO cliente envia uma mensagem para o SO remoto.
4. O SO remoto dá a mensagem ao apêndice do servidor.
5. O apêndice do servidor desempacota e chama o servidor.
6. O servidor executa e retorna o resultado para o apêndice.
7. O apêndice servidor empacota o resultado em uma mensagem e chama o SO local.
8. O SO do servidor envia a mensagem ao SO do cliente
9. O SO do cliente dá a mensagem ao apêndice de cliente
10. O apêndice desmpacota o resultado e retorna ao cliente.

 

## Comunicação orientada à mensagem

 - Usada para atender comportamento síncrono do SD
 - Possibilidade de execução com o sistema operando plenamente.
 - Possibilidade de tratamento em fila.
 - Duas abordagens:
  - Sockets
  - Interface de passagem de mensagem (mPI).

### Sockets

 - Terminal de comunicação
 - Carrega poucos dados

#### Primitivas da interface socket:


Primitiva | Descrição
----------|:-----------:
SOCKET    | Cria o terminal de comunicação
BIND      | Anexa um endereço a um socket
LISTEN    | Anuncia a disposição de aceitar conexões
ACCEPT    | Bloqueia o chamador até chegar uma requisição de comunicação
CONNECT   | Tenta estabelecer uma conexão
SEND      | Envia alguns dados pela conexão
RECEIVE   | Recebe alguns dados pela conexão
CLOSE     | Tenta fechar uma conexão 


### MPI

 - Acompanha a evolução dos multicomputadores.
 - Sobrecarga mínima do sistema.
 - Pode ser aplicadas também a protocolos proprietários.
 - Ideal para sincronismo.
 - Auxílio na portabilidade das aplicações.

#### Primitivas do MPI:


Primitiva    | Significado
------------ | :---------------:
MPI_bsend    | Anexa uma mensagem de saída a um buffer local de envio
MPI_send     | Envia uma mensagem e espera até que seja copiada para o buffer local ou remoto
MPI_ssend    | Envia uma mensagem e espera até o recebimento começar
MPI_sendrecv | Envia uma mensagem e espera por resposta
MPI_isend    | Passa referência para a mensagem de saída e continua
MPI_issend   | Passa referência para a mensagem de saída e espera até o recebimento começar
MPI_recv     | Recebe uma mensagem; bloqueia se não houver nenhuma
MPI_irecv    | Verifica se há uma mensagem chegando, mas não bloqueia




