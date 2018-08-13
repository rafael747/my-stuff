function x = criteriocoluna(A)
// Verifica se o Criterio das Linhas é satisfeito
[m,n] = size(A);
if m~=n, error('Matriz A deve ser quadrada'); end

for j = 1:n
    alfaK=0;
    for i = 1:n
        if i ~= j then
            alfaK = alfaK + abs(A(i,j)/A(i,i));
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

