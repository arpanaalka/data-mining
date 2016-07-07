function [idx,visit] = expandcluster(i,idx,neighbor_pts,X,clust_num,eps,minpts,visit)
    idx(i) = clust_num;
    for j=1:length(neighbor_pts)
        if visit(neighbor_pts(j))~=1
            visit(neighbor_pts(j))=1;
            neighbor_pts1 = region_query(X(neighbor_pts(j),:),X,eps);
            if sum(neighbor_pts1)-1 >= minpts
               neighbor_pts = [neighbor_pts;neighbor_pts1];
            end
        end
        if idx(neighbor_pts(j))==0
           idx(neighbor_pts(j))=clust_num; 
        end
    end
end
