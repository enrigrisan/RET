function [xc,yc,dir,d]=RETtrackpath(x,xp,yp,rettppar,dbf);
if dbf, disp('>>> Inside RETtrackpath'); end;

th=rettppar.th;
ps=rettppar.ps;
diamini=rettppar.diamini;
dmin=rettppar.dmin;
vcmin=rettppar.vcmin;
w1=rettppar.w1;
w2=rettppar.w2;
rdc=rettppar.rdc;

% RETscan : linear profile
tf=1; 

%debug flags
dbfscan=0;
dbfpick=0;

sxp=length(xp);

for ct=1:sxp,
    
    if dbf,
        disp(sprintf('Point %i of %i',ct,sxp));
    end;
    
    if ct~=sxp,
        ang=atan2(yp(ct+1)-yp(ct),xp(ct+1)-xp(ct));
    else
        ang=0;
    end;
    
    [xnew,ynew,lnew,v]=RETscanman(x,th,xp(ct),yp(ct),0,ps,ang,diamini,dmin,vcmin,5,dbfscan);
    if ct>1,
        if length(xnew),
            [xs,ys,ls,ndir,eci]=RETpick(xc(ct-1),yc(ct-1),dir(ct-1),d(ct-1),xnew,ynew,lnew,w1,w2,rdc,dbfpick);
            if ~eci,
                xc(ct)=xs;
                yc(ct)=ys;
                dir(ct)=ang;
                d(ct)=ls;
            else
                xc(ct)=xp(ct-1);
                yc(ct)=yp(ct-1);
                dir(ct)=ang;
                d(ct)=d(ct-1);
            end;
        else
            xc(ct)=xp(ct-1);
            yc(ct)=yp(ct-1);
            dir(ct)=ang;
            d(ct)=d(ct-1);
        end;
    else
        xc(ct)=xnew(1);
        yc(ct)=ynew(1);
        dir(ct)=ang;
        d(ct)=lnew(1);
    end;
end;

if dbf, disp('>>> Finished RETtrackpath'); end;