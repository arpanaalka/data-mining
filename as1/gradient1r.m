function [omega1,error1,error2]=gradient1r(x,y,vx,vy,omega,alpha,numiter,lambda)

n=length(y);
vn=length(vy);
error1= zeros(numiter,1);
error2= zeros(numiter,1);
lambda;
for i=1:numiter
	delta_j = (x*omega - y);
	delta_j = delta_j'*x;
	delta_j = delta_j/n;
	k=omega(1);
	omega = omega*(1-alpha*lambda/n) - alpha*delta_j';
	omega(1)=omega(1) + (alpha*lambda/n)*k;

	error2(i)=(x*omega-y)'*(x*omega-y);	%training error
	error2(i)=error1(i)/n;

	error1(i)=(vx*omega-vy)'*(vx*omega-vy); 	%validation error
	error1(i)=error1(i)/vn;
end
omega1=omega
end


