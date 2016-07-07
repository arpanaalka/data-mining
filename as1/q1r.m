data=csvread('/home/arpana/datam/as2/aa/Data3.csv');
data3=1;
[r,c] = size(data);
b=floor(0.7*r); %hold on
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
alpha=0.01;
omega=zeros(c,1);

vx=ones(r-b,c);
vx(1:r-b,2:c)=v;

lambda= 0
[omega,err,error1]=gradient1r(x,y,vx,vy,omega,alpha,numiter,lambda);
		%gradient end


if data3==0
figure;
y=zeros(100,100);
x1=linspace(-4,4,100);
x2=linspace(-4,4,100);
for i=1:100
	for j=1:100
		y(i,j) = omega'*[1;x1(i);x2(j)];
	endfor
endfor
surf(x1,x2,y');

hold on;
plot3(data(:,1),data(:,2),data(:,3));
hold off; 

size(err)
figure;
plot(1:numel(err),err);
endif

if data3==1
	figure;
	size(x*omega);
	plot(x(:,2),x*omega,'-r');
	hold on;
	plot(x(:,2),y,'+b');
	hold off; 

	size(err);
	figure;
	plot(1:numel(err),err);
endif
