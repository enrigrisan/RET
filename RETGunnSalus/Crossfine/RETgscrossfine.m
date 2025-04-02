% RETcrossfine
% Tries to estimated in a finer way than RETcross the crosspoint.
% It achieves this by performing a local tracking, given the starting and 
% ending points
% It gives on the output the estimated crosspoint coordinates xc,yc,
% and the two local trackings
% RETcrossfine(xroif,v1,v2,options,err,dbf)
% xroif  : upsampled smoothed image of a small ROI about the estimated crossing
% v1,v2  : structures describing the two crossing segments
% options: tracking step and minimum distance from the end points before stopping
% err    : error flag coming from RETinitializegs
% fdb    : debug flag

function [xc,yc,ves1,ves2,err]=RETgscrossfine(xroif,v1,v2,options,dbf);

if dbf, disp('Inside RETcrossfine'); end;

mindis=max(v1.dim*10,v2.dim*10);
step=options.step;
mintheta=options.mintheta;

err=0;

theta=angolo(v1.dir(1,:),dbf);
minjmp=v1.dim*5;
[x1,y1,err]=RETgsprofile(xroif,v1,step,mindis,mintheta,minjmp,dbf);
ves1.x=x1;
ves1.y=y1;

if ~err,
    theta=angolo(v2.dir(2,:),dbf);
    minjmp=v2.dim*5;
    [x2,y2,err]=RETgsprofile(xroif,v2,step,mindis,mintheta,minjmp,dbf);
    ves2.x=x2;
    ves2.y=y2;
end;

if ~err,
    %linear interpolation along x and y, with free variable the curvilinear
    %coordinate t
    t1=RETparam(x1,y1,dbf);
    t2=RETparam(x2,y2,dbf);
    p1x=polyfit(t1,x1',1);
    p1y=polyfit(t1,y1',1);
    p2x=polyfit(t2,x2',1);
    p2y=polyfit(t2,y2',1);
    
    %crossing calculation
    t2c=(p1y(1)/p1x(1)*(p2x(2)-p1x(2))+p1y(2)-p2y(2))*p1x(1)/(p2y(1)*p1x(1)-p1y(1)*p2x(1));
    xc=p2x(1)*t2c+p2x(2);
    yc=p2y(1)*t2c+p2y(2);
    
    if dbf,
        figure
        imshow(xroif)
        hold on
        plot(polyval(p1x,t1),polyval(p1y,t1),'g');
        plot(polyval(p2x,t2),polyval(p2y,t2),'g');
        plot(xc,yc,'om');
    end;
end;

if dbf, disp('Exit RETcrossfine'); end;

