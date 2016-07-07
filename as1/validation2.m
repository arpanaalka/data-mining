function[omega]=validation2(omega,x,y,v,vy,alpha)
W=omega;
n1 = length(vy);
n = length(y);
%a=x*W;		      	 %f_w(x)
%delta_J =(a-y)'*x;
%delta_J=delta_J/n;
%nj=length(omega);
J_w= zeros(1,1000);
	%W = W-alpha*(delta_J)';
	W;
	%a1=v*W;	
	%J(w)= 1/2n sigma(from 1 to n)(f_w(x_i)-y_i)^2	      	
	%J_w(1)= (a1-vy)'*(a1-vy);
	%J_w(1)= J_w(1)/(n1);
	%error1 = J_w(1);	
	for i = 1:1000
		a=x*W;
		delta_J =x'*(a-y);
		delta_J=delta_J/n;
		W = W-alpha*(delta_J);

		%J(w)= 1/2n sigma(from 1 to n)(f_w(x_i)-y_i)^2	      	
		a1=v*W;		
		J_w(i)= (a1-vy)'*(a1-vy);
		J_w(i)= J_w(i)/(n1);
		error1 = J_w(i);
	
	end
omega=W
size(J_w)
figure;
plot(1:numel(J_w), J_w, '-b');
end


