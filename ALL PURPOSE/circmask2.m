function z=circmask2(d1,d2,rx1,rx2,ry1,ry2)

ccen=d1-ceil(d1/2)+1;
rcen=d2-ceil(d2/2)+1;
m=zeros(d1,d2);
for c=(ccen-fix(rx2)-1):ccen,
   for r=(rcen-fix(ry2)-1):rcen,
      if (rx1~=0)|(ry1~=0), v1=sqrt(((c-ccen)/rx1)^2+((r-rcen)/ry1)^2); else v1=1; end;
      v2=sqrt(((c-ccen)/rx2)^2+((r-rcen)/ry2)^2);
      if (v1>=1)&(v2<=1) 
         m(c,r)=1; 
         m(2*ccen-c,2*rcen-r)=1;
         m(c,2*rcen-r)=1; 
         m(2*ccen-c,r)=1;
      end;
   end;
end;

z=m;

   