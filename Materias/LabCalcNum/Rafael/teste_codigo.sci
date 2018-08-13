X=[-1,-.75,-.6,-.5,-.3,0,.2,.4,.5,.7,1] //pontos x
F=[2.05,1.153,0.45,0.4,0.5,0,.2,.6,.512,1.2,2.05] //pontos f(x)

function [y]=g1(x)  //função g1 =x^2
    y=x.^2
endfunction


gxLista=list(g1)    //listas com funções g

a=quadrados_minimos(X,F,gxLista) //a recebe o coeficiente da aproximação

plot(X,F,'o') //plot dos pontos

plot(-1:.1:1,a(1).*g1(-1:.1:1)) //plot da função


