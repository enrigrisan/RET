function U = initfcm2(cluster_n, data_n, data)

if size(data,2)==1,
   U = [data';1-data'];
else
   dataic=data-ones(data_n,1)*min(data);
   dataic=dataic./(ones(data_n,1)*max(dataic));
   dataic=dataic*cluster_n;
   dataic=dataic.*(dataic<cluster_n)+(cluster_n-1)*(dataic==cluster_n);
   dataic=fix(mean(dataic')')+1;
   U=zeros(cluster_n,data_n);
   for ct=1:data_n,
      U(dataic(ct),ct)=1;
      if dataic(ct)~=1,
         U(dataic(ct)-1,ct)=0.5;
      end;
      if dataic(ct)~=cluster_n,
         U(dataic(ct)+1,ct)=0.5;
      end;
   end;
end;

col_sum = sum(U);

U = U./col_sum(ones(cluster_n, 1), :);
