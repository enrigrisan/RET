function xn=RETnormalize(x,dbf)

if dbf, disp('Inside RETnormalize'), end
xn=x;
i=find(x>0);
minx=min(x(i));
maxx=max(x(i));

if maxx-minx
   xn(i)=(x(i)-minx)/(maxx-minx);
end
if dbf, disp('Finished RETnormalize'), end
