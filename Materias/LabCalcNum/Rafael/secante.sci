function [raiz, x, iter, ea]=secante(xi,xf,f,tol,imax)
iter = 0; // inicializa numero de iteracoes
x1 = xi;
x2 = xf
//x(iter+1)=x1; // insere raiz inicial no vetor de raizes
while (1)
    xrold = x2; 
    xr = x2-f(x2).*(x1-x2) ./(f(x1)-f(x2)) 
    iter = iter+1;
    x(iter)=xr 
    
    if(xr ~= 0) then // calcula erro relativo
        ea(iter)=abs((xr-xrold)/xr);
    end;
    if(ea(iter) <= tol) then // se erro relativo menor que tol, FIM
        raiz = xr;
        return;
    end;
    if(iter >= imax) then // se excedeu num. maximo de iteracoes, FIM
        error('Número Máximo de Iterações Alcançado');
    end;
    
    x1=x2
    x2=xr
    
end
