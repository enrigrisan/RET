function [ker1,ker2]=circsectormask(r,a1,a2);
ker1=zeros(2*r+1);
if nargout>1,
   fc=1;
else
   fc=0;
end;
if fc, 
   ker2=zeros(2*r+1);
end;
a1=unwrap(a1);
a2=unwrap(a2);
if(a1==pi),
   a1=-pi;
end;
%if (a1>=0)&(a2<=0), 
if (a1>=a2), 
   f=1; 
else
   f=0;
end;
for ctr=1:2*r+1,
   for ctc=1:2*r+1,
      a=atan2((ctr-r-1),(ctc-r-1));
      if ((ctr-r-1)^2+(ctc-r-1)^2)<r^2,
         if (a>=a1)&(a<=a2),
            ker1(ctr,ctc)=1;
         else
            if fc, ker2(ctr,ctc)=1; end;
         end;
      end;
      if f,
         if ((ctr-r-1)^2+(ctc-r-1)^2)<r^2,
            if ((a>=a1)&(a<=pi))|((a<=a2)&(a2>=-pi)),
               ker1(ctr,ctc)=1;
            else
               if fc, ker2(ctr,ctc)=1; end;
            end
         end;
      end;
   end;
end;
