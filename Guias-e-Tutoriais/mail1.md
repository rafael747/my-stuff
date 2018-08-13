# Configurando o Email no Ubuntu 

 - MTA: postfix
 - MDA: dovecot
 - Filtro: Spamassassin

## Passo 1 - Configurando um FQDN

#### Alterar o hostname:


	sudo vim /etc/hostname


> Colocar qualquer nome. EX: **mail**


#### Alterar o FQDN:


	sudo vim /etc/hosts


#### Alterar a linha que começa com 127.0.1.1:


	127.0.1.1   mail.x.ibilce.net



### Passo 1.5 - Criando certificados

	openssl genrsa -des3 -out server.key 2048
	openssl rsa -in server.key -out server.key.insecure
	mv server.key server.key.secure
	mv server.key.insecure server.key
	openssl req -new -key server.key -out server.csr
	openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
	sudo cp server.crt /etc/ssl/certs
	sudo cp server.key /etc/ssl/private


> Atenção: Esses comandos servem para criar um certificado auto-assinado

## Passo 2 - Instalando o Postfix

    sudo apt update
    sudo apt install postfix

> Selecione a opção "Internet Site"

> Insira o seu domínio sem o nome da máquina
> EX:  "x.ibilce.net"
 
### Altere o arquivo de configuração em "/etc/postfix/main.cf"

#### Insira as seguintes linhas

	home_mailbox = Maildir/
	smtpd_sasl_type = dovecot
	smtpd_sasl_path = private/auth
	smtpd_sasl_local_domain =
	smtpd_sasl_security_options = noanonymous
	broken_sasl_auth_clients = yes
	smtpd_sasl_auth_enable = yes
	smtpd_recipient_restrictions = permit_sasl_authenticated,permit_mynetworks,reject_unauth_destination
	smtp_tls_security_level = may
	smtpd_tls_security_level = may
	smtp_tls_note_starttls_offer = yes
	smtpd_tls_loglevel = 1
	smtpd_tls_received_header = yes
	smtpd_tls_key_file = /etc/ssl/private/server.key
	smtpd_tls_cert_file = /etc/ssl/certs/server.crt



### Altere o arquivo de configuração em "/etc/postfix/master.cf"

#### Descomente as seguintes linhas:

	submission inet n       -       -       -       -       smtpd
	  -o syslog_name=postfix/submission
	  -o smtpd_tls_security_level=encrypt
	  -o smtpd_sasl_auth_enable=yes
	  -o smtpd_relay_restrictions=permit_sasl_authenticated,reject
	  -o milter_macro_daemon_name=ORIGINATING
	smtps     inet  n       -       n       -       -       smtpd
	  -o syslog_name=postfix/smtps
	  -o smtpd_tls_wrappermode=yes
	  -o smtpd_sasl_auth_enable=yes
	  -o smtpd_relay_restrictions=permit_sasl_authenticated,reject
	  -o milter_macro_daemon_name=ORIGINATING
	
## Passo 3 - Instalando o Dovecot

	sudo apt install dovecot-core dovecot-imapd dovecot-pop3d

### Altere o arquivo de configuração "/etc/dovecot/conf.d/10-master.conf"

##### Encontre este treixo e deixe como segue:

	# Postfix smtp-auth
	unix_listener /var/spool/postfix/private/auth {
	mode = 0660
	user = postfix
	group = postfix
	}

### Altere o arquivo de configuração "/etc/dovecot/conf.d/10-auth.conf"

#### Altere a seguinte linha

	auth_mechanisms = plain login


### Altere o arquivo de configuração "/etc/dovecot/conf.d/10-mail.conf"

#### Descomente a linha

	mail_location = maildir:~/Maildir

#### Comente a linha

	mail_location = mbox:~/mail:INBOX=/var/mail/%u


### Altere o arquivo de configuração "/etc/dovecot/conf.d/10-ssl.conf"

#### Altere essa configuração:

	ssl = yes

	ssl_cert = </etc/ssl/certs/server.crt
	ssl_key = </etc/ssl/private/server.key


## Parte 4 - Instalando Spamassassin

	sudo apt install spamassassin spamc

### Altere o arquivo de configuração "/etc/postfix/master.cf"

#### Encontre e altere a seguinte linha:


	smtp      inet  n       -       -       -       -       smtpd
	 -o content_filter=spamassassin


#### Adicione a seguinte entrada no final do arquivo:

	spamassassin unix -     n       n       -       -       pipe
	  user=debian-spamd argv=/usr/bin/spamc -f -e  
	  /usr/sbin/sendmail -oi -f ${sender} ${recipient}


> Tome cuidado com os espaçoes

## Parte 5 - Ative e reinicie os serviços


	sudo systemctl enable spamassassin.service
	sudo systemctl start spamassassin.service
	sudo systemctl restart dovecot
	sudo systemctl restart postfix.service


## Referências 

https://www.howtoforge.com/tutorial/getting-started-with-lets-encrypt-on-ubuntu/
https://www.digitalocean.com/community/tutorials/how-to-configure-a-mail-server-using-postfix-dovecot-mysql-and-spamassassin
http://www.krizna.com/ubuntu/setup-mail-server-ubuntu-14-04/
