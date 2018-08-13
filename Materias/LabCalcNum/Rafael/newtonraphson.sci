function [raiz, x, iter, ea]=newtonraphson(x0,f,fp,tol,imax)
iter = 0; // inicializa numero de iteracoes
xr = x0; // inicializa raiz aproximada com a inicial
x(iter+1)=x0; // insere raiz inicial no vetor de raizes
while (1)
    xrold = xr; 
    xr = xrold - f(xrold)/fp(xrold); // aplica formula de Newton
//disp(f(xrold),'funcao')
//disp(fp(xrold))    
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
        return
        error('Número Máximo de Iterações Alcançado');
        
    end;
end
