function [omega1,error1]=gradient1(x,y,vx,vy,omega,alpha,numiter)

n=length(y);
vn=length(vy);
error1= zeros(numiter,1);
for i=1:numiter
	delta_j = (x*omega - y);
	delta_j = delta_j'*x;
	delta_j = delta_j/n;
	omega = omega - alpha*delta_j';

	error1(i)=(vx*omega-vy)'*(vx*omega-vy);
	error1(i)=error1(i)/vn;

end
omega1=omega
end


