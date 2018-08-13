function y=f(x)
    y=(1 ./(sqrt(x))) + 2.*log10(%e).*log(0.0000810811 + (2.51 ./ (13743.017 .* sqrt(x))))
endfunction

x=0.001:0.001:0.1  //intervalo para estimar a raiz
//plot(x,f(x))
//xgrid()

// raiz entre 0.01 e 0.05

exec("falsaP.sci");

[raiz,x1,it,ea]=falsaP(0.01,0.05,f,1e-6,200)

//raiz =  0.0289678
//iterações = 20
//erro relativo final = 0.0000007

function y=fp(x)
    y= -(1 ./(2.*(x.^(3/2)))) - log10(%e) .* 2.51 ./(12743.017) .* 1 ./((0.0000810811 + 2.51 ./ (13743.017 .* sqrt(x))) .* x ^(3/2)) 
endfunction

exec("newtonraphson.sci");

//[raiz2,x2,it2,ea2]=newtonraphson(0.008,f,fp,1e-6,200)

//raiz =  0.0289678
//iterações = 7
//erro relativo final = 0.00000005

[raiz3,x3,it3,ea3]=newtonraphson(0.08,f,fp,1e-6,3)

// max de iterações

x=0.01:0.01:1
plot(x,f(x))






