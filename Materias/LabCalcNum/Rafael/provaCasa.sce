// Problema 1

z=[0,4,8,12,16]
a=[9.8175, 5.1051, 1.9635, 0.3927, 0]
c=[10.2, 8.5, 7.4, 5.2, 4.1]

//numero de ponto = 5
//numero de intervalos = 4 (par)

//podemos usar simpson1/3

cMedia = simpson13tab(z,a.*c) / simpson13tab(z,a)

disp(cMedia,"PROBLEMA 1 - Concentração média: ")

// Problema 2

t=[0,10,20,30,35,40,45,50]
q=[4, 4.8, 5.2, 5, 4.6, 4.3, 4.3, 5]
c=[10, 35, 55, 52, 40, 37, 32, 34]

//numero de pontos igual a 8
//numero de intervalos = 7 (impar)

//podemos usar simpson3/8 nos 4 primeiros pontos 
// com 3 intervalos com espaçamento igual a 10

//em seguida, aplicar simpson1/3 nos 5 ultimos pontos
// com 4 intervalos com espaçamento igual a 5

massa = simpson38simplesTab(t(1:4),q(1:4).*c(1:4))
massa = massa + simpson13tab(t(4:8),q(4:8).*c(4:8)) 

disp(massa,"PROBLEMA 2 - Massa: ")


