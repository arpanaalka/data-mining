function [omega] = validationr(omega,x,y,v,vy,alpha)
W=omega;
n1 = length(vy);
n = length(y);
lambda = 1;
%a=x*W;
%size(a)
%size(x)	
%size(W)	      	 %f_w(x)
%delta_J =(a-y)'*x;
%delta_J=delta_J/n;
%nj=length(omega);
J_w= zeros(1,1000);
	for i = 1:1000
		i;
		a=x*W;
		size(a);
		size(y);
		delta_J =x'*(a-y);
		size(delta_J);
		delta_J=delta_J/n;
		t = W(1);
		W = W*(1-alpha*lambda/n)-alpha*(delta_J);
		W(1) = W(1)+(alpha*lambda/n)*t;

		%J(w)= 1/2n sigma(from 1 to n)(f_w(x_i)-y_i)^2	      	
		a1=v*W;		
		J_w(i)= (a1-vy)'*(a1-vy);
		J_w(i)= J_w(i)/(n1);
		error1 = J_w(i);
	
	end
omega=W
%size(J_w)
%figure;
%plot(1:numel(J_w), J_w, '-b');
end


