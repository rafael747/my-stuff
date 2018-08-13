//-----------------------------------------
// Ajustando Modelo Nao Linear satutração 2 
// Função Linear: g1=1, g2=x
function [y]=g1a(x)
    y=ones(1,size(x,2));

endfunction

function [y]=g2a(x)
    y=x;
endfunction

//Tabela de Dados (Original)
x = [1.3, 1.8, 3, 4.5, 6, 8, 9];
fx = [0.07, 0.13, 0.22, 0.275, 0.335, 0.35, 0.36];

// Tabela Modificada pela Aplicação
X = x.^-2;
F = fx .^-1;

// Lista de Funções
gLista = list(g1a,g2a);

// Chama função Quadrados Minimos
exec("quadrados_minimos.sci");
[a]=quadrados_minimos(X,F,gLista)

// Calcula parâmetros do Modelo Original
Vm = 1.0 ./a(1);
Ks =sqrt( a(2) / a(1));


disp(Vm, "VM = ")
disp(Ks," KS = ")

// Graficos da Regresssao Linear
//figure(1)
//plot(X,F,'o');
//xlx=0:.1:10
//ylx= a(1)+a(2)*xlx;
//plot(xlx,ylx)

// Graficos do Modelo Nao Linear Original
figure(2)
plot(x,fx,'o');
xx = 0:.1:10;
yy=(Vm*xx.^2)./(Ks^2+xx.^2)
plot(xx,yy)

//função que representa o modelo
//function [y]=fun(x)
 //   y=alfaO.*x^betaO
//endfunction
/////////////////////////////////

//disp(fun(35),"Força a 35 m/s:")

//disp(fun(100),"Força a 100 m/s:")
