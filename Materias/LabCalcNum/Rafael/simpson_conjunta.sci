function [I] = simpson_conjunta(func, a, b, ns)
    
    h = (b-a)/ns
    I=0
    
    if modulo(ns,2) ~= 0 then  //se for impar
        [I1] = simpson38simples(func,b-3*h,b)
        //disp(I1)
        if ns-3 ~= 0 then
            [I2]=simpson13(func,a,b-3*h,ns-3) 
            //disp(I2)
        end
        I=I1+I2
    else
        I = simpson13(func,a,b,ns)
    end
    
endfunction
