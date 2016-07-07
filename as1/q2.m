data=csvread('/home/arpana/as2/aa/Data2.csv');
[r,c] = size(data);
x=data;
%degree i
g=data1(100,1);
data1(100,i+1)=[g g.*g g.*g.*g data(:,c)]
[r,c] = size(data1);
x=data1;


%normalization

%mindata=min(data1(:,1:c-1));
%maxdata=max(data1(:,1:c-1));
%data1(:,1:c-1)=(data1(:,1:c-1)-mindata)./(maxdata-mindata);

%normalization end

%hold on 
b=floor(0.7*r);
v = ones(1:r-b,1:c);
t = ones(1:b,1:c);

t(1:b,2:c) = data1(1:b,1:c-1);
v(1:r-b,2:c) = data1(b+1:r,1:c-1);
%hold on end
abc1
%x = ones(b,c);
%x= t;
abc2
y = data1(1:b,c);
abc3
omega = zeros(c,1);
alpha=0.001;

%validation
omega = zeros(c,1);
v(1:r-b,2:c) = data1(b+1:r,1:c-1);
vy = data1(b+1:r,c);
[omega] = validationr(omega,t,y,v,vy,alpha);


%plot
figure;
X=[ones(r,1) data(:,1:2)];
size(X);
Y = X*omega;
size(Y);
Y-data1(:,c);
%plot(data(:,1), data(:,2)
x1=linspace(-4,4,100);
x2=linspace(-4,4,100);
y=zeros(100,100);
for i=1:100
  for j=1:100
    y(i,j) = omega'*[1;x1(i);x2(j)];
  end
end
y=y';
surf(x1,x2,y);
hold on;
plot3(data1(:,1), data1(:,2), data1(:,3));
hold off;
