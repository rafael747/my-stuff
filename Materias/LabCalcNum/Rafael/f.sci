function y=f(x)
    y=x^2-7.6.*x+11.55
endfunction

function y=fp(x)
    y=2.*x-7.6
endfunction

function y=f2(x)
    y=x^3+4.*x.*cos(x) - 2    
endfunction
    
function y=fp2(x)
    y=3.*x^2 + 4.*cos(x) - 4.*x.*sin(x)
endfunction
