function [theta]=angolo(vec,dbf);

if(dbf)
   disp('Inside angolo')
end;

den=vec(1);
num=vec(2);
if(den==0&num>=0)
   theta=pi/2;
elseif(and(den==0,num<0)),
   theta=3*pi/2;
else
   theta=atan(num/den);
end;

if(num>0&den<0)
   theta=theta+pi;
elseif(num<=0&den<0)
   theta=theta+pi;
elseif(num<=0&den>0),
   theta=theta+2*pi;
end;

if(dbf)
   disp('Exit angolo')
end;
