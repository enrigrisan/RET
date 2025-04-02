function [ec,xc,yc]=RETsegcross(seg,a,b,crosspar,dbf),
% q: segments sampling step
% d: index backtracking for cross configuration detection

q=crosspar.q;
d=crosspar.d;
distestr=crosspar.destr^2;
distminab=crosspar.dminab^2;

if dbf, disp('Inside RETsegcross'); end;

distestr=distestr^2;
ec=0;
xc=[];
yc=[];
sxa=length(seg(a).x);
sxb=length(seg(b).x);
xa=seg(a).x(1:q:sxa);
ya=seg(a).y(1:q:sxa);
xb=seg(b).x(1:q:sxb);
yb=seg(b).y(1:q:sxb);
sxa=length(xa);
sxb=length(xb);

% setting of minimum distance vector (on a running coordinate on vector b
% vector amin keeps the corresponding index on vector a)
distm=distmatrix([xb,yb],[xa,ya]);
for ct1=1:sxb,
    dist=distm(ct1,:);
    k=find(dist==min(dist));
    k=k(1);
    distmin(ct1)=dist(k);
    amin(ct1)=k;
end;

if min(distmin)<distminab,
    
    [tmp,p]=minloc(distmin,2);
    
    for ct1=1:length(p),
        k=p(ct1);
        dist1=(xb(1)-xb(k))^2+(yb(1)-yb(k))^2;
        dist2=(xb(sxb)-xb(k))^2+(yb(sxb)-yb(k))^2;
        dist3=(xa(1)-xa(amin(k)))^2+(ya(1)-ya(amin(k)))^2;
        dist4=(xa(sxa)-xa(amin(k)))^2+(ya(sxa)-ya(amin(k)))^2;
        
        
        if min([dist1,dist2,dist3,dist4])>distestr,
            
            x1=xb(max(1,k-d));
            y1=yb(max(1,k-d));
            x2=xb(min(sxb,k+d));
            y2=yb(min(sxb,k+d));
            x3=xa(max(1,amin(k)-d));
            y3=ya(max(1,amin(k)-d));
            x4=xa(min(sxa,amin(k)+d));
            y4=ya(min(sxa,amin(k)+d));
            
            eci=RETcrosspoints([x1,x2,x3,x4],[y1,y2,y3,y4],dbf);
            
            if eci==1
                ec=1;
                xm=mean([x1,x2,x3,x4]);
                ym=mean([y1,y2,y3,y4]);
                xc=[xc,xm];
                yc=[yc,ym];
            end
        end;
    end;
end;

if dbf, disp('Finished RETsegcross'); end;


function [y,p]=minloc(x,k),
% Massimo DeLuca
% determines local minima in vector x
% parameter k determines the half neighborhood size

y=[];
p=[];
lx=length(x);
for i=1:lx,
   xp=x( max(1,i-k):i-1);
   xs=x(min(i+1,lx):min(i+k,lx));
   if  min([xp,xs])> x(i),
      y=[y,x(i)];
      p=[p,i];
   end;
end;
