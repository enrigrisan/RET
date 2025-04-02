function rseeds=RETcutseed3(seeds,xroi,nsd,dbf)

if dbf, disp('Inside RETcutseed3'); end;

sseeds=length(seeds);

for ct=1:sseeds,
    rmax=min([20,seeds(ct).x-1,seeds(ct).y-1,size(xroi,2)-seeds(ct).x-1,size(xroi,1)-seeds(ct).y-1]);
    xroiloc=xroi(seeds(ct).y-rmax:seeds(ct).y+rmax,seeds(ct).x-rmax:seeds(ct).x+rmax);
    vth(ct)=std2(xroiloc);
end;

th=mean(vth)-nsd*std(vth);

i=vth>th;

rseeds=seeds(i);

if dbf, disp('Finished RETcutseed3'); end;
    