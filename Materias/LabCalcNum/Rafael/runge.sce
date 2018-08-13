
// Usa a tabela para fazer a interpolação em xx
function [yint]=avalia_interp_pol(x,xi,tabdd)
n=length(x)
xt=1;
yint=b(1,1);
for j=1:n-1 //nova
    xt=xt*(xi-x(j));
    yint=yint+b(1,j+1)*xt;
end
endfunction

// Gera amostra da função de Runge com 10 pontos
// Avalia polinomio de interpolação nesses pontos
// Plota o gráfico
x=linspace(-1,1,11)

//disp(x)
//disp(xi)
// Use a forma de newton apenas para gerar a tabela de diferencas divididas
exec("newton_interp.sci");
fx=1.0./(1+25*x.^2);
[yint,b]=newton_interp(x, fx, 0)
//disp(b)

xr=linspace(-1,1,101)
n=length(xr)
for i=1:n
    yr(1,i)=avalia_interp_pol(x,xr(1,i),b)
end
disp(xr)
disp(yr)
plot(xr,yr,'b')

// Plota a função de Runge nos mesmos pontos
xx=linspace(-1,1,101)
yy=1.0./(1+25*xx.^2);
plot(xx,yy,'r')


