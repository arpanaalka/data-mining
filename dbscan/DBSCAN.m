 %function []= DBSCAN(eps,minpts)
X = csvread('/home/arpana/datam/cluster2.csv');
[r,c]=size(X);
visit = zeros(r,1);
idx = zeros(r,1);
clust_num = 0;

while ~all(visit==1)
	i = randperm(r,1);
	if visit(i)==1
		continue;
	else
	visit(i)=1;
	P = X(i,:);
	neighbor_pts = region_query(P,X,eps);
	if sum(neighbor_pts)-1 < minpts
		visit(i)=2;
	else
	clust_num = clust_num+1;
	[idx,visit]=expandcluster(i,idx,neighbor_pts,X,clust_num,eps,minpts,visit);
	end
	end
end

figure;
hold on;
for i=1:r
    if idx(i)==1
        plot3(X(i,1),X(i,2),'*c');
    elseif idx(i)==2
        plot3(X(i,1),X(i,2),'*b');
    elseif idx(i)==3
        plot3(X(i,1),X(i,2),'*g');
    elseif idx(i)==4
        plot3(X(i,1),X(i,2),'*k');
    elseif idx(i)==5
        plot3(X(i,1),X(i,2),'*r'); 
    end
end

end



% unvisited:0, visited:1, noise:2
%eps3:data2,esp4:data1
%minpts10:data2,minpts8:data1


