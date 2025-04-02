function seg_out=RETsegav(seg_in,x,y,p,dbf);

if(dbf)
   disp('Inside RETsegav');
end;

pos=1;
seg_out=seg_in;

for ct=1:length(seg_in),
   n=length(seg_in(ct).x);
   pa=sum(p(pos:pos+n-1,3))/n;
   pv=sum(p(pos:pos+n-1,1))/n;
   pnc=sum(p(pos:pos+n-1,2))/n;
   seg_out(ct).pav=[pv,pnc,pa];
   pos=pos+n;
end;

if(dbf)
   disp('Finished RETsegav');
end;

