%RETinitializegs
% Perform the initalizations and extracts the parameters used in evaluating the 
% Gunn and Salus sign
% Returns the filtered and upsampled version of a ROI centered on the estimated
% cross point given in cross,
% the two structures for the two vessels involved in the crossing, containing each
% start and end point, mean diameter of the vessel, directions between the start
% and end point

function [xroif,v1,v2,dimroi,err]=RETgsinitialize(x,seg,cross,options,dbf);

if dbf, disp('Inside initialize'); end;

searcoeff=options.searcoeff;
smooth=options.smooth;
maxd=options.maxd;
err=0;

[x1,y1,x2,y2,direzioni1,direzioni2,dim1,dim2]=RETgsestraiinit(seg,cross,dbf);

% Computation of the loacal ROI dimension, according to the vessels
% diameters and a minimum dimension
dpoints=[sqrt((x1-cross.x).^2+(y1-cross.y).^2);sqrt((x2-cross.x).^2+(y2-cross.y).^2)];
d1=max(max(dpoints));
dimroi=max(min(40,max(4*dim1,4*dim2)),d1+10);

err=0;

% the initial point to be reliable have to be at a certain distance from the
% ROI borders

if(d1>maxd),
    err=2;
    v1.x=0;
    v1.y=0;
    v2.x=0;
    v2.y=0;
    v1.diam=0;
    v2.diam=0;
    v1.direzioni=0;
    v2.direzioni=0;
    xroif=[];
end;

if(isempty(dim1)|isempty(dim2)),
    err=1;
    v1.x=0;
    v1.y=0;
    v2.x=0;
    v2.y=0;
    v1.diam=0;
    v2.diam=0;
    v1.direzioni=0;
    v2.direzioni=0;
end;  

if length([x1,x2,y1,y2])~=8,
    v1.x=0;
    v1.y=0;
    v2.x=0;
    v2.y=0;
    v1.diam=0;
    v2.diam=0;
    v1.direzioni=0;
    v2.direzioni=0;
    err=1;
end;

if ~err,
    v1.x=x1-cross.x+dimroi+1;
    v1.y=y1-cross.y+dimroi+1;
    v1.diam=searcoeff*dim1*10;
    v1.dim=dim1;
    v1.dir=direzioni1;
    v2.x=x2-cross.x+dimroi+1;
    v2.y=y2-cross.y+dimroi+1;
    v2.diam=searcoeff*dim2*10;
    v2.dim=dim2;
    v2.dir=direzioni2;
    
    %Roi filtering and expansion
    xroi1=x(fix(cross.y-dimroi-10):fix(cross.y+dimroi+10),fix(cross.x-dimroi-10):fix(cross.x+dimroi+10));
    sxroi=size(xroi1);
    xroif1=nmlz2(medfilt2(xroi1,[5,5]));
    xroif1=xroif1(10:sxroi(1)-10,10:sxroi(2)-10);
    sxroif1=size(xroif1);
    xroif=imresize(xroif1,[(sxroif1(1)-1)*10+1,(sxroif1(2)-1)*10+1],'bicubic');
    xroif=nmlz(xroif);
end;

if dbf, disp('Exit initialize'); end;
