function x = criteriosassenfeld(A)
// Verifica se o Criterio das Linhas é satisfeito
[m,n] = size(A);
if m~=n, error('Matriz A deve ser quadrada'); end

betaK=zeros(n,1);
for i = 1:n

    for j = 1:n
        if j <= (i-1) then
            betaK(i) = betaK(i) + abs(A(i,j)/A(i,i))*betaK(j);
        elseif j >= (i+1) then
            betaK(i) = betaK(i)+abs(A(i,j)/A(i,i))
        end        
    end
    if betaK(i) >= 1 then
        x=%f;
        return
    end
end
x=%t;
return
endfunction

