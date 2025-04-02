function [c1,c2,r1,r2]=RETgscontrollabound(r,c,theta,diam,sxroi,dbf);

if dbf, disp('Inside RETgscontrollabound'); end;

sr=length(c);
if(c(sr)+diam/2*sin(theta-pi/2)>sxroi(2)),
   c1=sxroi(2);
elseif(c(sr)+diam/2*sin(theta-pi/2)<1)
   c1=1;
else
   c1=c(sr)+diam/2*sin(theta-pi/2);
end;

if(c(sr)+diam/2*sin(theta+pi/2)>sxroi(2)),
   c2=sxroi(2);
elseif(c(sr)+diam/2*sin(theta+pi/2)<1)
   c2=1;
else
   c2=c(sr)+diam/2*sin(theta+pi/2);
end;

if(r(sr)+diam/2*cos(theta-pi/2)>sxroi(1)),
   r1=sxroi(1);
elseif(r(sr)+diam/2*cos(theta-pi/2)<1)
   r1=1;
else
   r1=r(sr)+diam/2*cos(theta-pi/2);
end;

if(r(sr)+diam/2*cos(theta+pi/2)>sxroi(1)),
   r2=sxroi(1);
elseif(r(sr)+diam/2*cos(theta+pi/2)<1)
   r2=1;
else
   r2=r(sr)+diam/2*cos(theta+pi/2);
end;

if dbf, disp('Finished RETgscontrollabound'); end;