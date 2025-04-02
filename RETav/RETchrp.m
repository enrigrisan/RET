function p=RETchrp(x,y,c,xyz,lab,alfa,dbf);

if dbf, disp('Inside RETchrprel'); end;

n=length(x);

cond(:,1)=xyz(:,2);
cond(:,2)=c(:,2);
m=mean(cond);
sd=std(cond);

p1=(cond(:,1)<(m(1)-alfa(1)*sd(1))&cond(:,1)>(m(1)-alfa(2)*sd(1)))&(cond(:,2)<(m(2)-alfa(1)*sd(2))&cond(:,2)>(m(2)-alfa(2)*sd(2)));
%p1=(cond(:,1)<(m(1)-alfa(1)*sd(1)))&(cond(:,2)<(m(2)-alfa(1)*sd(2)));
p3=(cond(:,1)>(m(1)+alfa(1)*sd(1))&cond(:,1)<(m(1)+alfa(3)*sd(1)))&(cond(:,2)>(m(2)+alfa(1)*sd(2))&cond(:,2)<(m(2)+alfa(3)*sd(2)));
p2=(~p1)&(~p3);
p=[p1,p2,p3];

if dbf, disp('Finished RETchrprel'); end;
