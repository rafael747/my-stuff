function [I] = simpson38simples(func, a, b)
 
    h = (b-a)/3
    x=a
    soma=func(a)+func(b)
    for i=1:2
        x=x+h
        soma=soma+3*func(x)
    end
    I=(3*h/8)*soma
endfunction
