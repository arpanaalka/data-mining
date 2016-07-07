data = csvread('/home/arpana/datam/kmeans/cluster1.csv');
[r,c] = size(data);
k = 4;
m = max(max(data));
numiter = 16;
maxiter = 28;
cost = zeros(numiter,maxiter);
final = 1;
p1 = zeros(numiter,1);
MIN = 1e10;

for iter = 1:numiter
    mpre = randi(m,k,c);
    index = findmean(data,mpre);
    mfinal = ComputeMu(data,index,k);

    dist = 0;
    for i=1:k
        dist = dist+sqrt((mpre(i,:)-mfinal(i,:))'*(mpre(i,:)-mfinal(i,:)));
    end

    mpre = mfinal;
    p = 0;

    while dist~=0
        index = findmean(data,mpre);
        mfinal = computemean(data,index,k);

        dist = 0;
        for i=1:k
            dist = dist+sqrt((mpre(i,:)-mfinal(i,:))'*(mpre(i,:)-mfinal(i,:)));
        end
        mpre = mfinal;

        sum1 = 0;
        for j=1:r
            sum1 = sum1 + sqrt((data(j,:)-mfinal(index(j),:))'*(data(j,:)-mfinal(index(j),:)));
        end
        p = p+1;
        cost(iter,p) = sum1;

        if p > maxiter
            break;
        end
    end
    
    p1(iter) = p;
    if cost(iter,p)<MIN
        final = iter;
        ID = index;
        MIN = cost(iter,p);
    end
    
end

figure;
hold on;
for i=1:r
    if ID(i)==1
        plot3(data(i,1),data(i,2),data(i,3),'*b');
    elseif ID(i)==2
        plot3(data(i,1),data(i,2),data(i,3),'*r');
    elseif ID(i)==3
        plot3(data(i,1),data(i,2),data(i,3),'*k');
    else
        plot3(data(i,1),data(i,2),data(i,3),'*g');
    end
end
figure;
plot(1:p1(final),cost(final,1:p1(final))','-r');



