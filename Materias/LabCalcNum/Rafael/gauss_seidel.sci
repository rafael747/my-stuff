function [x,iter,ea] = gauss_seidel(A,b,x0,tol,imax)
    [m,n]=size(A)
    iter=1
    while iter <= imax
        for i=1:m
            su=0
            for j=1:n
                if j<i then
                    su=su+A(i,j).*x(j)
                elseif j>i then
                    su=su+A(i,j).*x0(j)   
                end
            end
            x(i)=1 ./A(i,i) .* (b(i)-su)
            
               
        end
        
        ea = norm(x-x0,'inf')/norm(x,'inf')
        if ea <= tol then
            return
        end
        
        iter=iter+1
        x0=x
                
    end
    error('Max de iterações')
