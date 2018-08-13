function [I] = simpson13tab(x, fx)
    nx=size(x,2)
    nfx=size(fx,2)

    if nx ~= nfx then
        error("vetores de tamanhos diferentes")
    end
    if modulo(nx-1,2) ~= 0 then
        error("O número de pontos deve ser par ")
    end
    h=x(2)-x(1)
   
    soma=fx(1)+fx(nx)

    for i=1:nx-2
        if modulo(i,2) == 0 then
            soma = soma + 2*fx(i+1)
        else
            soma = soma + 4*fx(i+1)
        end
    end
    I=(h/3)*soma
endfunction
