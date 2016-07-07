function neighbor_pts = region_query(P,X,eps)
    r = size(X,1);
    dis = zeros(r,1);

    for i=1:r
        dis(i) = sqrt((P-X(i,:))*(P-X(i,:))');
    end
    dis = dis < eps;
   neighbor_pts = find(dis==1);
end
