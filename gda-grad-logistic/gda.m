data=csvread('/home/arpana/datam/as3/Data1.csv');
[r,c] = size(data);
x1=data;
x=x1(:,1:c-1);
y=x1(:,c);
[r,c] = size(x);
for i=1:r
	if y(i)==-1
		y(i)=0;
	end 
end

m=length(y);
size(x)
size(y)
k = sum(y);
a=1;
b=1;
x0 = zeros(m-k,c);
x1 = zeros(k,c);
y0 = zeros(m-k,1);
y1 = zeros(k,1);

for i=1:r
	if y(i)==0
		x0(a,:) = x(i,:);
		y0(a) = y(i);
		a=a+1;
	else
		x1(b,:) = x(i,:);
		y0(b) = y(i);
		b= b+1;  
	end
end

m1=mean(x1);
m0=mean(x0);

for i=1:k
	x1(i,:) = x1(i,:)-m1;
end

for i=1:m-k
	x0(i,:) = x0(i,:)-m0;
end

X=[x0;x1];
Y=[y0;y1];

sigma = (X'*X);
sigma = sigma/c; 
inv_sigma = inv(sigma);

omega0 = (m0*inv_sigma*m0')-(m1*inv_sigma*m1')+2*log(k/(m-k));
omega0 = omega0/2;
omega1 = inv_sigma*(m1'-m0');
omega = [omega0;omega1];

X = [ones(r,1) X];
y1 = 1./(1+exp(-X*omega));

figure;
hold on;

for i=1:r
	if data(i,3)==1
		plot(data(i,1),data(i,2),'*r');
	else
		plot(data(i,1),data(i,2),'+b');
	end
end

boundary = -(omega(1)+omega(2)*data(:,1))/omega(3);
plot(data(:,1),boundary,'-b'); 




