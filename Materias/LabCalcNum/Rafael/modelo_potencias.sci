//-----------------------------------------
// Ajustando Modelo Nao Linear f(x)=alfa * v ^beta
//-----------------------------------------
// Função Linear: g1=1, g2=x
function [y]=g1a(x)
    y=ones(1,size(x,2));
endfunction

function [y]=g2a(x)
    y=x;
endfunction

//Tabela de Dados (Original)
x = [10, 20, 30, 40, 50, 60, 70, 80];
fx = [25, 70, 380, 550, 610, 1220, 830, 1450]

// Tabela Modificada pela Aplicação
X = log(x);
F = log(fx);

// Lista de Funções
gLista = list(g1a,g2a);

// Chama função Quadrados Minimos
exec("quadrados_minimos.sci");
[a]=quadrados_minimos(X,F,gLista)

// Calcula parâmetros do Modelo Original
alfaO = exp(a(1));
betaO = a(2);


//disp(alfaO)
//disp(betaO)

// Graficos da Regresssao Linear
//figure(1)
//plot(X,F,'o');
//xlx=0:.5:8
//ylx= a(1)+a(2)*xlx;
//plot(xlx,ylx)

// Graficos do Modelo Nao Linear Original
//figure(2)
//plot(x,fx,'o');
//xx = 0:1:100;
//yy=alfaO*xx.^betaO
//plot(xx,yy)

//função que representa o modelo
function [y]=fun(x)
    y=alfaO.*x^betaO
endfunction
/////////////////////////////////

disp(fun(35),"Força a 35 m/s:")

disp(fun(100),"Força a 100 m/s:")
