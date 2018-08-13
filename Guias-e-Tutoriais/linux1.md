## Assuntos interessantes para usuários Linux

 - Terminal linux
   - comandos basicos
   - permições
   - pipes
   - file descriptors
   - exit status 

 - Editando arquivos pelo terminal
   - nano
   - vim

 - Escaneando um host 
   - nc
   - nmap

 - Capturando pacotes
   - wireshark
   - tcpdump


---------------------

 
## Terminal Linux

### Comando básicos

 - Obtendo acesso root

Obter uma shell interativa como root:

	su

> precisa que a senha de root estaja definida

	sudo su

> root não precisa ter uma senha definida

> utiliza a senha de um usuário privilegiado (ver sudors)

Executar comando diretamente como root:

	su -c <comando>
	sudo -c <comando>

 - Verificar tamanho de diretorios

Para verificar o tamanho de arquivos:

	ls -lha

> dessa forma não é possível verificar o tamanho de pastas

	du -sh <pasta>

> agora podemos ver o tamanho de pastas também

> OBS: com "du -ah" podemos ver o tamanho de arquivos também (recursivamente)


 - Verificar tamanho de dispositivos


```
	df -h
```

 - Permições 

Podemos verificar as permições dos arquivos com:

	ls -lha


### Permições

Para alterar as permições de um arquivo

	chmod <permições> <arquivo>

as permições podem ser da seguinte forma (u=user, g=group, o=others):

	ugo=rwx
	u=rwx,g=rw,o=x
	u+x,og-wx

Ou ainda

	  u   g   o
	|rwx|rwx|rwx|
	
	 111 110 100

	  7   6   4


	chmod 764 <arquivo>
	chmod u=rwx,g=rw,o=r <arquivo>

 - Dono de um arquivo

Podemos verificar o dono de um arquivo com:

	ls -lha <arquivo>

No seguinte formato:

	<user>:<group>

EX: root:root


 - Alterar o dono de um arquivo

```
	chown <user>:<group> <arquivo>
```

> para alterar permições ou autoria recursivamente, usar -R 

### pipes

Util para usar a saída de um programa como entrada para outro

	<comando1> | <comando2>

> A saída do comando1 é usado como entrada do comando2

> OBS: Somente a saida padrão (stdout) é considerada (visto a seguir).

EX:

	ls -1 |wc -l

> lista os arquivos, um por linha (-1), e conta a quantidade de linhas (wc -l)

> Resultado: Conta a quantidade de arquivos em uma pasta

EX2:

	cat <arquivo> | grep "<padrão>"

> procura por padrões em arquivos


### file descriptors

De onde vem as entradas e vão as saídas

Temos pelo menos 3 fds para cada programa em execução
	
 - stdin
Entrada de dados, possui o número "0" e seu simbolo é "<".

	comando

> entrada de dados via teclado

	comando < arquivo

> entrada de dados a partir de "arquivo"

 - stdout
Saída padrão (sem erros), número "1" e simbolo ">"

Normalmente é a tela, mas pode ser redirecionada para um arquivo, por exemplo

	comando

>saída de dados na tela

	comando > file.txt

>saída de dados vai para o arquivo

	comando > /dev/null

>descartando a saida padrão

 - stderr
Saída com erro, número "2" e simbolo "2>"

Normalmente é a tela. É identido ao stdout, podem não é passado via pipe

EX:

	echo 1+1 | bc 

	echo 1+1 >&2| bc

> verifique as diferenças


Para redirecionar tanto stdout quanto stderr

	comando &> file.txt

Para mais detalhes:
http://www.catonmat.net/blog/bash-one-liners-explained-part-three/


### Verificar o exit status

útil para verificar se algum comando executou com sucesso

	0 = sucesso (sem erro)
	qualquer outro = não sucesso (verificar outros status)
 

Verificar saída de algum comando:
	
	<comando>
	echo $?

Executar comando se o ultimo foi concluido com sucesso (exit 0)

	comando1 && comando2

Executar comando se o ultimo não foi concluido com sucesso (!= 0)

	comando1 || comando2

Usando estrutura condicional com saída de um programa

	if <comando>
	then
		....
	fi	

> Se comando sair com sinal 0 (sucesso) entra no if



## Editando arquivos pelo terminal

Muitas vezes não temos acesso à uma interface gráfica.
Nesse caso, quando precisamos editar um arquivo, usamos editores cli (command line interface)

 - nano
Se trata do editor mais simples e presente na maior parte dos sistemas.

	nano <arquivo>

 - vim
Se trata de um editor mais robusto, porém, não vem por padrão em alguns sistema

	vim <arquivo>

> Para um estudo mais aprofundado das funções do vim: **vimtutor**


## Escaneando hosts

As vezes precisamos fazer algumas operações simples envolvendo sockets

A ferramenta mais simples e flexível para essa tarefa é o **netcat**

Podemos fazer algumas operações como:

	nc <host> <porta>

> tentar conexão com o <host> na <porta> especificada

	nc -l <porta>

> escutar por conexão na <porta>

A partir dessas operações podemos, por exemplo:

	nc -l 2000 > arquivo.txt     (host1)

	nc host1 2000 < arquivo.txt  (host2)

> transferir arquivo do host2 para o host1

> OBS: todo o tráfego não é cifrado


Podemos inclusive fazer varreduras em portas de um host

	nc -v -z  <host> <intervalo-portas>

> somente verifica de a porta esta aberta (-z), e mostra ao usuário (-v)


 - Scans mais elaborados com **nmap**

Alguns exemplos de varredura utilizando o nmap

	nmap <host>

> Escaneia pelas 1000 portas mais comuns utilizando a tecnica TCP connect

	nmap <host> -p <portas>

> Define as portas a serem escaneadas

	nmap <host> -sS -F -T2

> Escaneia as 100 portas principais do host (-F) usando SYN scan (-sS) de forma lenta (-T2)

	man nmap 

>verificar outros tipos de varredura oferecidos pela ferramenta

## Capturando pacotes

Muitas vezes precisamos capturar os pacotes de uma rede, a maioria das vezes para diagnosticar problemas.

Umas das ferramentas mais classicas de captura de pacote é o **tcpdump**

Uso mais simples da ferramenta:

	tcpdump -i <interface> -w arquivo.pcap

> captura todo o tráfico que chega a <interface> e salva em "arquivo.pcap"

Podemos também aplicar filtros e exibir o conteudo da captura na tela

	tcpdump -i <interface> udp port 9 -v -A

> filtra por UDP e porta 9, mostra mais informações (-v) e mostra o conteudo na tela (-A) em ASCII

 - Wireshark
Ferramenta visual para a captura e visualização de pacotes na rede.
útil para analisar dados capturados pela ferramenta **tcpdump**

Mais informações:
http://www.howtogeek.com/104278/how-to-use-wireshark-to-capture-filter-and-inspect-packets/
