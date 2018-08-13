function x = gauss_simplorio(A,b)
// Método da Eliminação de Gauss Sem Pivotamento
[m,n] = size(A);
if m~=n, error('Matriz A deve ser quadrada'); end
// Construindo a Matriz Aumentada [A b]
nb = n+1;
Aug = [A b];
// Fase 1: Eliminação
for k = 1:n-1
    for i = k+1:n 
        m = Aug(i,k)/Aug(k,k);
        //disp(m)
        Aug(i,k:nb) = Aug(i,k:nb)-m*Aug(k,k:nb);
    end
end

// Fase 2: Solução do Sistema Triangular - Retrosubstituição
x = zeros(n,1);
x(n) = Aug(n,nb)/Aug(n,n);
for i = n-1:-1:1
    x(i) = (Aug(i,nb)-Aug(i,i+1:n)*x(i+1:n))/Aug(i,i);
end
