


X = csvread('/home/arpana/datam/kmeans/cluster1.csv');
[r,c]=size(X);
visit = zeros(r,1);
% 0--->unvisited, 1--->visited, 2--->noise

eps = 2;  %2 ---> cluster2, 2---->cluster1
minpts = 30; %6 --->cluster2, 30--->cluster1
idx = zeros(r,1);
clust_num = 1;

for i=1:r
   if visit(i)~=1
      visit(i)=1;
      P = X(i,:);
      nbd = findnbd(P,X,eps);
      if numel(nbd) < minpts
          visit(i)=2;
      else
          [idx1,visit] = expandcluster(i,idx,nbd,X,clust_num,eps,minpts,visit);
          clust_num = clust_num+1;
          idx = idx1;
      end
   end
end

figure;
hold on;
for i=1:r
    if idx(i)==0
        plot3(X(i,1),X(i,2),X(i,3),'*k');
    elseif idx(i)==1
        plot3(X(i,1),X(i,2),X(i,3),'*r');
    elseif idx(i)==2
        plot3(X(i,1),X(i,2),X(i,3),'*b');
    elseif idx(i)==3
        plot3(X(i,1),X(i,2),X(i,3),'*g');
    elseif idx(i)==4
        plot3(X(i,1),X(i,2),X(i,3),'*c'); 
    end
end




















































































































































































































































































































































































































































function []= DBSCAN(eps,minpts)
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


