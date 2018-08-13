## Aula 12 - 06/11/2017
-------

## 5) Busca Competitiva

Neste contexto aborda-se o conceito de ambiente **competitivo**, em que os **objetivos** dos agentes estão em **conflito**. Isto ocasiona a **busca competitiva**, a qual também é conhecida como **jogos**.
O conceito de jogos advém da **teoria dos jogos**, a qual visualiza um ambiente multiagente como um jogo, em que um agente **impacta** sobre o outro (cooperativo ou competitivo).

Basicamene, em I.A. os jogos podem assumir duas vertentes:
 - **Deterministico**: Bastante especializada, com caracteristicas que são espelhadas entre os agentes.
 > EX: Um ganha, outro perde
 
  - **Eurísticas**: Quando existe incerteza na ocorrencia das ações, com fatores que podem **influenciar** na tomada de **decisoes**.
  
  Um jogo pode ser definido formalmente como:
  
   - **S0**: Estado inicial -> como o jogo é criado.
   - **Jogadores**: Agente que é identificado.
   - **Ações**: Retornam um conjunto de movimentos válidos.
   - **Resultados**: O modelo de transição.
   - **Teste de Término**: Estamos que finalizam.
   - **Utilidade**: Função objetivo que define um valor numérico para um determinado estado final.
