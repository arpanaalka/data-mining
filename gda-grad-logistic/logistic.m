function [omega1,error1]=logistic(x,y,omega,alpha,numiter)

n=length(y);
error1= zeros(numiter,1);
size(x);
size(y);
size(omega);
for i=1:numiter
	f=1./(1+exp(-(x*omega)));
%f=f';
	delta_j = (f - y);
size(f);
	delta_j = delta_j'*x;
	delta_j = delta_j/n;
	omega = omega - alpha*delta_j';

	error1(i)=-y'*log(f)-(1-y)'*log(1-f);
	error1(i)=error1(i)/n;

end
size(f);
omega1=omega;
end


