% RETfindgunn determines the four point identifying the crossing by 
% evaluating the radial profiles centered on the estimated crosspoint.
% It gives on the output the matrix d of the coordinates of thos points,
% and the correpondent estimated diameters.
% RETfindgunn(xroif,x,y,v1,v2,options,err,dbf)
% xroif: region of interest image
% x,y  : coordinates of the estimated crosspoint
% v1,v2: structures describing the two crossing segments
% options: radial step and gray level threshold
% err  : error flag coming from RETinitializegs
% fdb  : debug flag

function [d,diam,dis,der,err]=RETfindgunn(xroif,x,y,v1,v2,options,dbf);

if dbf, disp('Inside RETfindgunn'); end;

diam1=v1.diam;
diam2=v2.diam;
stepth=options.stepth;
th=options.th;
sxroif=size(xroif);
width=min([max([diam1,diam2]),0.5*(sxroif(2)-x),0.5*(sxroif(1)-y)]);
n=[];

%Number of contour points
points=2*pi/stepth;

%Approximate again the cross point, by finding the centroid of the contour
%found by RETgunncontour
[dis,der]=RETgunncontour(xroif,x,y,width,stepth,th,dbf);
theta1=0;
for prof1=1:length(der)
    d1(prof1,:)=[x+der(prof1)*cos(theta1),y+der(prof1)*sin(theta1)];
    theta1=0+prof1*stepth;
end;
df=sqrt((x-d1(:,1)).^2+(y-d1(:,2)).^2);
ndf=find(df<2*width);
x=mean(d1(ndf,1));
y=mean(d1(ndf,2));

%If the centrid gray level is higher than th, the contrast is assumed too low,
%the algorithm stops with an error flag
err=(xroif(fix(y),fix(x))>=th);

if ~err,
    %Evaluate the contour for estimating the four points describing the crossing
    [dis,der]=RETgunncontour(xroif,x,y,width,stepth,th,dbf);
    
    %Find the four points
    n=RETgsfindedge(dis,der,points,dbf);
    
    if dbf,
        disp(['Position of edge points :',num2str(n)]);
    end;
    
    d(1,:)=[x+der(n(1))*cos(n(1)*stepth),y+der(n(1))*sin(n(1)*stepth)];
    d(2,:)=[x+der(n(2))*cos(n(2)*stepth),y+der(n(2))*sin(n(2)*stepth)];
    d(3,:)=[x+der(n(3))*cos(n(3)*stepth),y+der(n(3))*sin(n(3)*stepth)];
    d(4,:)=[x+der(n(4))*cos(n(4)*stepth),y+der(n(4))*sin(n(4)*stepth)];
    
    %Computing the four diameters
    for ct=1:4,
        ind1=ct;
        if ct==4,
            ind2=1;
        else
            ind2=ct+1;
        end;
        temp(ct)=sqrt((d(ind1,1)-d(ind2,1))^2+(d(ind1,2)-d(ind2,2))^2);
    end;
    diam(1)=0.5*(temp(1)+temp(3));
    diam(2)=0.5*(temp(2)+temp(4));
    
    if dbf,
        figure
        imshow(xroif)
        hold on
        plot(x,y,'om');
        for prof1=1:length(der)
            theta1=0+prof1*stepth;
            d1=[x+der(prof1)*cos(theta1),y+der(prof1)*sin(theta1)];
            plot([d1(1)],[d1(2)],'*g');
        end;
        for ct=1:4,
            plot(d(ct,1),d(ct,2),'om');
        end;
        hold off
    end;
end;

if dbf, disp('Exit RETfindgunn'); end;



