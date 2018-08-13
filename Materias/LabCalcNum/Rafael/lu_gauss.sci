function [x,L,U] = lu_gauss(A,b)
// Método da Eliminação de Gauss Sem Pivotamento
[m,n] = size(A);
if m~=n, error('Matriz A deve ser quadrada'); end
// Inicializa Matriz Triangular Inferior com 1
// na diagonal ()
L=eye(A);
// Construindo a Matriz Aumentada [A b]
nb = n+1;
Aug = [A];
// Fase 1: Eliminação (nao manipula o vetor b)
for k = 1:n-1
    for i = k+1:n
        m = Aug(i,k)/Aug(k,k);
        Aug(i,k:n) = Aug(i,k:n)-m*Aug(k,k:n);
        // Armazena multiplicador na matriz L
        L(i,k)=m;
    end
end
// Terminou a Eliminação
// U é a parte triangular superior da matriz
// resultante da eliminação de Gauss
for k=1:n
    U(k,k:n)=Aug(k,k:n)
end

// Resolve sistema 
// Solução do Sistema Triangular Inferior
d=zeros(n,1);
d(1)=b(1)/L(1,1);
for i = 2:n
   d(i) = (b(i)-L(i,1:i-1)*d(1:i-1))/L(i,i);
end

// Solução do Sistema Triangular Superior
x = zeros(n,1);
x(n) = d(n)/U(n,n);
for i = n-1:-1:1
   x(i) = (d(i)-U(i,i+1:n)*x(i+1:n))/U(i,i);
end
endfunction
