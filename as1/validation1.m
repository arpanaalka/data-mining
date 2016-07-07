function[omega]=validation2(omega,x,y,v,vy,alpha)
abc
W(:,1)=omega;
n1 = length(vy);
n = length(y);
a=x*W(:,1);		      	 %f_w(x)
delta_J =(a-y)'*x;
delta_J'
%nj=length(omega);
J_w= zeros(101);
	W(:,2) = W(:,1)-alpha*(delta_J)';
W
	a1=v*W(:,1);	
	%J(w)= 1/2n sigma(from 1 to n)(f_w(x_i)-y_i)^2	      	
	J_w(1)= (a1-vy)'*(a1-vy);
	J_w(1)= J_w(1)/(n1);
	error1 = J_w(1);	
for i = 2:101
	a=x*W(:,i-1);
	delta_J =(a-y)'*x;
	delta_J';
	W(:,i) = W(:,i-1)-alpha*(delta_J)';

	%J(w)= 1/2n sigma(from 1 to n)(f_w(x_i)-y_i)^2	      	
	a1=v*W(:,i);		
	J_w(i)= (a1-vy)'*(a1-vy);
	J_w(i)= J_w(i)/(n1);
	error1 = J_w(i);
	
	end
mini= min(J_w);
i=0;
while mini!=J_w(i)
	i++;
	end
omega=W(:,i)	 
error1;
end


