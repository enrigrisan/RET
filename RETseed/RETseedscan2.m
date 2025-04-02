function [s,d]=RETseedscan2(x,th,dbf),

if dbf, disp('Inside RETseedscan'); end;

sx=length(x);
xf=conv(x,[1,1,1]/3);
xf=xf(2:2+sx-1);
dxf=-diff(xf);
dxf=[dxf,0];
s=[];
d1=[];
d2=[];
contr=[];

f=0;
k=1;
for i=2:sx,
    switch f,
    case 3,
        if dxf(i)>0,
            f=0;
            d2(k)=i;
            k=k+1;
        end;
    case 2,
        if dxf(i)>th,
            f=1;
        end;
        if dxf(i)<0,
            f=3;
            s(k)=i;
        end;
    case 1,
        if dxf(i)<th,
            d1(k)=i;
            f=2;
        end;
    case 0,
        if dxf(i)>th, 
            f=1;
        end;
    end;
end;

if length(d1)>length(d2),
    d1=d1(1:length(d1)-1);
end;

if length(s)>length(d1),
    s=s(1:length(s)-1);
end;
    
if length(d2),
    d=d2-d1;
else
    d=[];
end;

if dbf,
    if length(d2),
        i=[1:sx];
        figure;
        subplot(2,1,1);
        plot(i,xf,'x');
        subplot(2,1,2);
        plot(i,dxf,'x');
        hold on;
        plot(d1,ones(length(d1),1)*max(dxf),'or');
        plot(d2,ones(length(d2),1)*max(dxf),'or');
    end;
end;

if dbf, disp('Finished RETseedscan'); end;