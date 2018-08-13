# Author: rafael
###############################################################################
options(scipen=5)

args <- commandArgs(TRUE)

amostras <- as.numeric(args[1])
media <- as.numeric(args[2])
file <- args[3]

#amostras <- 100
#media <- 1/0.005
#file <- "teste.png"

# change to the new directory
setwd("/var/www/html/proba/img")
#setwd("/home/rafael/Desktop/fluxos")

x.gen <- rexp(n=amostras,rate=media)

png(filename=file,width=600,height=600)

hist(x.gen,prob=T,col="grey",axes=F,main="Distribuição Exponencial",xlab="Valores Gerados",ylab=NULL)
axis(1)

box()
grid()


leg1 <- paste("Média = ", round(mean(x.gen), digits = 4))
leg2 <- paste("Desvio Padrão = ", round(sd(x.gen),digits = 4))
leg3 <- paste("Mínimo = ",round(summary(x.gen)[1], digits = 4))
leg4 <- paste("1º Quadrante = ",round(summary(x.gen)[2], digits = 4))
leg5 <- paste("Mediana = ",round(summary(x.gen)[3], digits = 4))
leg6 <- paste("3º Quadrante = ",round(summary(x.gen)[5],digits = 4))
leg7 <- paste("Máximo = ",round(summary(x.gen)[6], digits = 4))

#legend(x = "topright", c(leg1,leg2,leg3,leg4,leg5,leg6,leg7),inset=0.03)


dev.off()

