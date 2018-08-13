function [raiz, x, iter, ea]=newtonraphsonPolinomial(x0,a,f,tol,imax)
iter = 0; // inicializa numero de iteracoes
xr = x0; // inicializa raiz aproximada com a inicial
x(iter+1)=x0; // insere raiz inicial no vetor de raizes
while (1)
    xrold = xr;
    [fp,dfp]=f(xrold,a) 
    xr = xrold - fp/dfp; // aplica formula de Newton
    iter = iter+1; // incrementa numero de iteracoes
    x(iter+1) = xr; // insere raiz aproximada no respectivo vetor
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
end
endfunction
