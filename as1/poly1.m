data=csvread('/home/arpana/datam/as2/polynomial_data.csv');
[r,c] = size(data);
x=data;
data1=data;
%degree i
g=data(:,1);
g1=g.*g;
g2=g1.*g;
y=data(:,2);
%data1=[g g.*g]
size(data1)
data1=[g g1 g2 y];

degree=5;
X=zeros(r,degree);
for i=1:degree
	X(:,i) = g.^i;
end

data=X;
[r,c] = size(data)
b=floor(0.9*r); %hold on
t=data(1:b,1:c-1);
size(t)
v=data(b+1:r,1:c-1);
y=data(1:b,c);
vy=data(b+1:r,c);

		%normalization traindata

%mindata=min(data(:,1:2));
%maxdata=max(data(:,1:2));

		%normalization val data using train min and max
%t=(t-mindata)./(maxdata-mindata);
%v=(v-mindata)./(maxdata-mindata);
		%normalization end



		%gradient
x=ones(b,c);
size(x)
size(t)
x(:,2:c)=t;
numiter=1000;
alpha=0.0001;
omega=zeros(c,1);

vx=ones(r-b,c);
vx(1:r-b,2:c)=v;

lambda= 1;
z=zeros(50,1);
z1=zeros(50,1);
for k=1:50
	[omega1,err,errt]=gradient1r(x,y,vx,vy,omega,alpha,numiter,k);
	z(k) = err(numiter);
	z1(k) = errt(numiter);
endfor


		%gradient end


figure;
size(x*omega1);
plot(x(:,2),x*omega1,'*r');
hold on;
plot(x(:,2),y,'+b');
hold off; 

size(err);	%validation
figure;
plot(1:numel(err),err);
xlabel('iterations');
ylabel('error');
title('val error vs iterations');

figure;
plot(1:numel(z),z,'-b');
xlabel('lambda');
ylabel('error');
title('error vs iterations');
hold on;
plot(1:numel(z1),z1,'-r');
legend('training err','val error');
hold off;

size(errt);	%training 
figure;
plot(1:numel(errt),errt);
xlabel('iterations');
ylabel('error');
title('training error vs iterations');
	

	


