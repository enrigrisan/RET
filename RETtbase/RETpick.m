function [x,y,d,ndir,ec]=RETpick(xatt,yatt,diratt,diamatt,xnew,ynew,lnew,w1,w2,rdc,dbf)

if dbf, disp('>>> Inside RETpick'); end;

dbar=atan2(ynew-yatt,xnew-xatt);

condang=abs(diratt-dbar);
if condang>pi, condang=2*pi-condang; end;

conddiam=(diamatt-lnew)/diamatt;

cond=w1*condang+w2*conddiam;

ic=find(cond==min(cond));
if size(ic,1)>1, ic=ic(1,:); end;

if length(ic);
    if lnew(ic)<=(1+rdc)*diamatt,
        x=xnew(ic);
        y=ynew(ic);
        d=lnew(ic);
        ndir=dbar(ic);
        ec=0;
    else
        x=[];
        y=[];
        d=[];
        ndir=[];
        ec=2;  %diameter condition
    end;
else
    x=[];
    y=[];
    d=[];
    ndir=[];
    ec=1;  %no look-ahead found
end;

if dbf, disp('>>> Finished RETpick'); end;

