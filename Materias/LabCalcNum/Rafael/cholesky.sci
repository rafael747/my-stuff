function [x,G] = cholesky(A,b)
// Método da Eliminação de Gauss Sem Pivotamento
[m,n] = size(A);
if m~=n, error('Matriz A deve ser quadrada'); end
for i=1:n
    for j=1:n
        if A(i,j)~=A(j,i), error('Matriz A deve ser simétrica'); end
    end
end

G=zeros(A)

G(1,1)=sqrt(A(1,1)) //primeiro elemento

for i=2:n   //primeira coluna
    G(i,1)=A(i,1)./G(1,1)
end

for k=2:n
    //calcula elemento da diagonal
    sum=0
    for i=1:k-1
        sum=sum+(G(k,i).^2)
    end
    G(k,k)=sqrt(A(k,k)-sum)
    
    //calcula os demais elementos
    for j=k+1:n
        sum=0
        for i=1:k-1
            sum=sum+(G(j,i).*G(k,i))
        end
        G(j,k)=(A(j,k)-sum)/G(k,k)
             
    end
    
end


Gt=G'



// Resolve sistema 
// Solução do Sistema Triangular Inferior
d=zeros(n,1);
d(1)=b(1)/G(1,1);
for i = 2:n
   d(i) = (b(i)-G(i,1:i-1)*d(1:i-1))/G(i,i);
end

// Solução do Sistema Triangular Superior
x = zeros(n,1);
x(n) = d(n)/Gt(n,n);
for i = n-1:-1:1
   x(i) = (d(i)-Gt(i,i+1:n)*x(i+1:n))/Gt(i,i);
end
endfunction
