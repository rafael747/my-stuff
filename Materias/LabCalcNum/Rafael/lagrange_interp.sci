function [y_interp] =  lagrange_interp(x, y, x_interp)

n=size(x,2) //numero de pontos
soma=0 //soma acumulada
for k=1:n //passando por todos os pontos
    produto=y(k) //fixa o valor y(k)
    for j=1:n //passa por todos os pontos
        if j ~= k then //menos quando k = j
            produto = produto * ((x_interp - x(j))/(x(k)-x(j)))
        end
    end
    soma=soma+produto //acumula
end
y_interp=soma

