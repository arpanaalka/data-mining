data=csvread('/home/arpana/datam/as3/Data1.csv');
[r,c] = size(data);
x1=data;

		%normalization traindata

%mindata=min(data(:,1:2));
%maxdata=max(data(:,1:2));

		%normalization val data using train min and max
%t=(t-mindata)./(maxdata-mindata);
%v=(v-mindata)./(maxdata-mindata);
		%normalization end



		%gradient
x=ones(r,c);
size(x)
x(:,2:c)=x1(:,1:c-1);
y=x1(:,c);

for i=1:r
	if y(i)==-1
		y(i)=0;
	endif 
endfor

alpha=0.1;
numiter=500;
omega=zeros(c,1);
[omega,err]=logistic(x,y,omega,alpha,numiter);
		%gradient end
figure;
hold on;
for i=1:r
if y(i)==1
	plot(data(i,1),data(i,2),'*r');
else
	plot(data(i,1),data(i,2),'+b');
end
end

y1 = -(omega(1)+omega(2)*data(:,1))/omega(3);
plot(data(:,1),y1,'-b');

size(err)
figure;
plot(1:numel(err),err,'-b');
d=1+exp(-x*omega);
Y = 1./(d);
disp(d);
Y = sort(Y,'descend');

spec =zeros(r,1);
sens = zeros(r,1);
i=0;
for i=1:r
thresh=Y(i);
N=(Y>=thresh);
N;
tp = and(N,y);
fp = and(N,~y);
tn = and(~N,~y);
fn = and(~N,y);
sens(i) = sum(tp)/(sum(tp)+sum(fn));
spec(i) = sum(fp)/(sum(tn)+sum(fp));
end

figure;
plot(spec,sens,'-b');

