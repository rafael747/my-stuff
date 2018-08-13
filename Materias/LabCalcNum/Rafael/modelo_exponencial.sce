//-----------------------------------------
// Ajustando Modelo Nao Linear f(x)=alfa e^(beta x)
//-----------------------------------------
// Função Linear: g1=1, g2=x
function [y]=g1a(x)
    y=ones(1,size(x,2));
endfunction

function [y]=g2a(x)
    y=x;
endfunction

//Tabela de Dados (Original)
x = [0.2 0.3 0.4 0.5 0.6 0.7 0.8];
//fx = [3.16 2.38 1.75 1.34 1.00 0.74 0.56] // Exponencial perfeita
fx = [3.0 2.38 1.75 1.1 1.00 0.65 0.56]

// Tabela Modificada pela Aplicação do Logaritmo
X = x;
F = log(fx);

// Lista de Funções
gLista = list(g1a,g2a);

// Chama função Quadrados Minimos
exec("quadrados_minimos.sci");
[a]=quadrados_minimos(X,F,gLista)

// Calcula parâmetros do Modelo Original
alfaO = exp(a(1));
betaO = a(2);

// Graficos da Regresssao Linear
figure(1)
plot(X,F,'o');
xlx=0:0.1:1
ylx= a(1)+a(2)*xlx;
plot(xlx,ylx)

// Graficos do Modelo Nao Linear Original
figure(2)
plot(x,fx,'o');
xx = 0:0.1:1;
yy=alfaO*exp(betaO*xx)
plot(xx,yy)

