[num,txt,raw] = xlsread('/home/arpana/datam/knn/crx.csv');
[r,c] = size(txt);
tmp = zeros(r,1);
for i=1:r
    tmp(i) = randi(r);
end
idt = unique(tmp);
ind = 1:1:r;
ind = ind';
idxV = setdiff(ind,idt);

numT = zeros(length(idt),size(num,2));
txtT = cell(length(idt),size(txt,2)-1);
yT = zeros(length(idt),1);
numV = zeros(r-length(idt),size(num,2));
txtV = cell(r-length(idt),size(txt,2)-1);
yV = zeros(r-length(idt),1);

for i=1:length(idt)
   numT(i,:) = num(idt(i),:);
   txtT(i,:) = txt(idt(i),1:size(txt,2)-1);
   if txt{idt(i),size(txt,2)}=='+'
       yT(i) = 1;
   else
       yT(i) = 0;
   end
end

for i=1:length(idxV)
   numV(i,:) = num(idxV(i),:);
   txtV(i,:) = txt(idxV(i),1:size(txt,2)-1);
   if txt{idxV(i),size(txt,2)}=='-'
       yV(i) = 1;
   else
       yV(i) = 0;
   end   
end

%numT = zscore(numT);
%numV = zscore(numV);

K = 11;
dis1 = zeros(length(idt),1);
dis2 = zeros(length(idt),size(txtT,2));
DIS = zeros(length(idt),1);
outV = zeros(length(idxV),1);

for i=1:length(idxV)
    for j = 1:length(idt)
        dis1(j) = norm(numV(i,:)-numT(j,:));
        dis2(j,:) = cellfun(@strcmp,txtV(i,:),txtT(j,:));
        DIS(j) = dis1(j)+sum(dis2(j,:));
    end
    [dis,id] = sort(DIS);
    pos = sum(yT(id(1:K)));
    neg = K-pos;
    if pos>neg
        outV(i) = 1;
    else
        outV(i) = 0;
    end
end

tp = sum(and(yV,outV))
tn = sum(and(~yV,~outV))
fp = sum(and(~yV,outV))
fn = sum(and(yV,~outV))
accuracy = (tp+tn)/(tp+tn+fp+fn)



