data=csvread('/home/arpana/as2/aa/Data1.csv');
[r,c] = size(data);
%x = ones(r,c);
%x(:,2:3) = data(:,1:2);
%y = data(:,3);

%normalization

mindata=min(data);
maxdata=max(data);
data=(data-mindata)./(maxdata-mindata);

%normalization end

%hold on 
b=floor(0.7*r);
v = zeros(1:r-b,1:3);
t = zeros(1:b,1:3);
t(1:b,2:3) = data(1:b,1:2);
v(1:r-b,2:3) = data(b+1:r,1:2);
%hold on end

%gradient
x = ones(b,c);
x = t;
y = data(1:b,3);
omega = zeros(c,1);
alpha=0.1;
%[omega] = gradient1(omega,x,y,alpha);
omega;
%gradient end

%validation
omega = zeros(c,1);
v(1:r-b,2:3) = data(b+1:r,1:2);
vy = data(b+1:r,3);
[omega] = validation1(omega,x,y,v,vy,alpha);
mini;
