function or=vtorient2(r,c);
rb=mean(r);
cb=mean(c);
s=zeros(2);
for ct=1:length(r),
   s=s+[r(ct);c(ct)]*[r(ct) c(ct)];
end;
s=s/length(r)-[rb;cb]*[rb,cb];
[tm, ev]=eig(s);
or=atan2(tm(2,1),tm(2,2));
if ev(1,1)<ev(2,2),
   or=atan2(tm(2,1),tm(2,2));
else
   or=atan2(tm(1,1),tm(1,2));
end;

    