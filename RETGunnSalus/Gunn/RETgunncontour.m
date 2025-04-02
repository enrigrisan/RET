% Contour function
% It evaluaes the radial profiles centered in (x,y) estimated crosspoint
% evaluates the vector dis of the gray level change along the profile,
% and the vector der of the minimum index for which the profile is
% greater then a given thershold th
function [dis,der]=RETgunncontour(xroif,x,y,width,stepth,th,dbf);

if dbf, disp('Inside contour'); end;

points=2*pi/stepth;
ct2=1;
sxroif=size(xroif);
dis=[];
der=[];

for ct=0:stepth:2*pi,
    width1=width;
    ec=0;
    while ~ec,
        ec=~(((x+width1*cos(ct))<sxroif(2))&((y+width1*sin(ct))<sxroif(1)));
        ec=ec|~(((x+width1*cos(ct))>0)&((y+width1*sin(ct))>0));
        if ~ec,
            prof=RETimprofile(xroif,[x,x+width1*cos(ct)],[y,y+width1*sin(ct)],dbf);
            ec=ec|any(prof>th);
            width1=1.5*width1;
        end;
    end;      
    if any(prof>th),
        n1=find(prof>=th);
        der(ct2)=n1(1);
        dis(ct2)=sum(prof(find(prof>th)))/sum(find(prof>th));
    else,
        der(ct2)=2*width;
        dis(ct2)=0;
    end;
    ct2=ct2+1;
end;

if dbf, disp('Finished contour'); end;