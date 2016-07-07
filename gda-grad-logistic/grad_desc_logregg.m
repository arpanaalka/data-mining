function [w f p] = grad_desc_logregg(X,Y,w)
p=X*w;
%plot(p,"b*");
T=e.^-(X*w);
f=1./(T+1);
Temp=X'*(f-Y);
alpha=0.01;
w=w+alpha.*(Temp);