function [y_interp,b] =  newton_interp(x, y, x_interp)
    n=size(x,2)
    
    //zerar b
    b=zeros(n,n)
    b(:,1) = y'
    //atribuir y a b(;1)
    disp(b)
    
    for j=2:n //primeira coluna ja preenchida
        for i=1:n-j+1
            
            b(i,j)= (b(i+1,j-1) - b(i,j-1)) / (x(i+j-1) - x(i))
            
        end
    end
    
    //Usar tabela para interpolar
    
    y_interp=b(1,1)
    xt=1
    for j=1:n-1
        xt = xt * (x_interp - x(j))
        y_interp = y_interp + b(1,j+1)*xt
    end
                
