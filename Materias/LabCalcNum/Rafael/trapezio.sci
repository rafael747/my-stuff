function [I] = trapezio(func, a, b, ns)
    h = (b-a)/ns //obter largura de cada trapezio
    x=a
    soma=func(a)+func(b)
    for i=1:ns-1
        x=x+h
        soma=soma+2*func(x) 
    end
    
    I=(h/2)*soma
endfunction
