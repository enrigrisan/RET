function plotcol(x,y,c,ps);
c=c-min(c);
c=c/max(c);
for ct=1:length(x),
   h=plot(x(ct),y(ct),ps);
   set(h,'Color',[c(ct),1-c(ct),0]);
end;

