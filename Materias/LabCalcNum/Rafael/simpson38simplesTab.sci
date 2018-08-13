function [I] = simpson38simplesTab(x,fx)
    nx=size(x,2)
    nfx=size(fx,2)
    
    if nx ~= nfx then
        error("vetores de tamanhos diferentes")
    end
    if nx ~= 4 then
        error("O número de pontos deve ser igual a 4")
    end
    h = x(2)-x(1)
    
    soma=fx(1)+ 3*fx(2)+3*fx(3) + fx(4)
    
    I=(3*h/8)*soma
endfunction
