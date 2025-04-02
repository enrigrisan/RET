function ec=RETcrosspoints(x,y,dbf)

if dbf, disp('Inside RETcrosspoints'); end;

ec=0;

xa=x(1);
ya=y(1);
xb=x(2);
yb=y(2);
xc=x(3);
yc=y(3);
xd=x(4);
yd=y(4);

a1=atan2(yb-ya,xb-xa);
a2=atan2(yc-ya,xc-xa);
a3=atan2(yd-ya,xd-xa);
ec1=sign(sin(a1-a2))~=sign(sin(a1-a3));

a1=atan2(yd-yc,xd-xc);
a2=atan2(ya-yc,xa-xc);
a3=atan2(yb-yc,xb-xc);
ec2=sign(sin(a1-a2))~=sign(sin(a1-a3));

ec=ec1&ec2;

if dbf, disp('Finished RETcrosspoints'); end;
