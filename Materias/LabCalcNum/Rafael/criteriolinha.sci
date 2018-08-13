function x = criteriolinha(A)
// Verifica se o Criterio das Linhas é satisfeito
[m,n] = size(A);
if m~=n, error('Matriz A deve ser quadrada'); end

for k = 1:n
    alfaK=0;
    for j = 1:n
        if j ~= k then
            alfaK = alfaK + abs(A(k,j)/A(k,k));
        end        
    end
    if alfaK >= 1 then
        x=%f;
        return
    end
end
x=%t;
return
endfunction

