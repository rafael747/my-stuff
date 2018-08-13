function [a]=quadrados_minimos(X,F,gxLista)
    
    n=size(gxLista)
    
    for i=1:n //considera o tamanho da lista gx
        
        gi=gxLista(i)(X) //monta vetor gi
        
        for j=i:n
            gj=gxLista(j)(X) //monta vetor gj
            G(i,j)=gi*gj'
            G(j,i)=G(i,j) //é simetrico
        end
        b(i)=F*gi'       
    end
    a=G\b
endfunction
