function rseeds=RETcutseedod(seeds,xod,yod,rod,dbf),

if dbf, disp('Inside RETcutseedod'); end;

[x,y,d,dir]=RETseedsextract(seeds,dbf);

dist=(x-xod).^2+(y-yod).^2;
p=dist>rod^2;
i=find(p);

rseeds=seeds(i);

if dbf, disp('Finished RETcutseedod'); end;
