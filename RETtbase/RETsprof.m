function [pchecked,xnew,ynew,lnew,vnew]=RETsprof(x,xatt,yatt,diratt,diamref,statt,psatt,th,dmin,vcmin,dbf);

statt2=statt;
psatt2=psatt;

limpsfactor=1.5;
limstfactor=1;

hdiamref=fix(diamref/3);

if ~hdiamref, hdiamref=1; end;
if ~statt, statt=1; end;

pchecked=0;
tf=0;

while ~pchecked&~tf,
    %[xnew,ynew,lnew,vnew]=OXYscan(x,th,xatt,yatt,statt2,0,diratt,psatt2,dmin,vcmin,1,dbf);
    [xnew,ynew,lnew,vnew]=RETscan(x,th,xatt,yatt,statt2,0,diratt,psatt2,dmin,vcmin,1,dbf);
    if length(xnew),
        %checking (validating) profile
        pchecked=RETapprove(vnew,th,dmin,lnew,diamref,dbf);
        %pchecked=1;
    else
        pchecked=0;
    end;
    
    if ~pchecked,
        if psatt2<limpsfactor*diamref,
            psatt2=psatt2+hdiamref;
        else
            psatt2=psatt;
            statt2=statt2-0.1*statt;
            if statt2<limstfactor,
                tf=1;
            end;
        end;
    end;
end;


