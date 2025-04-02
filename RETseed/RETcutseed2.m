function rseeds=RETcutseed2(seeds,dlims,dbf)

if dbf, disp('Inside RETcutseed2'); end;

sseeds=length(seeds);

xs=[];
ys=[];
ds=[];
    
j=1;
for i=1:sseeds,
   if (seeds(i).d>=dlims(1))&(seeds(i).d<=dlims(2)),
      rseeds(j)=seeds(i);
      j=j+1;
   end;
end

if dbf, disp('Finished RETcutseed2'); end;
