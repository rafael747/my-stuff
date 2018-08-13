function [f,fp]=fhorner(x0,a)
    n=length(a);
    y=a(n);
    z=a(n);
    for j=n-1:-1:2
        y=x0*y+a(j);
        z=x0*z+y;
    end
    y=x0*y+a(1);
    f=y;
    fp=z;
endfunction
