function ext=RETextrema(seg,npd,npb,dbf);
if dbf, disp('Inside RETextrema'); end;

sseg=length(seg);
for ct=1:sseg,
    ssegct=length(seg(ct).x);
    
    if ssegct<npb, 
        npbr=ssegct;
    else
        npbr=npb;
    end;
    
    if ssegct<npd, 
        npdr=ssegct;
    else
        npdr=npd;
    end;
    
    %extrema
    ext(2*ct-1).xe=seg(ct).x(1);
    ext(2*ct).xe=seg(ct).x(ssegct);
    ext(2*ct-1).ye=seg(ct).y(1);
    ext(2*ct).ye=seg(ct).y(ssegct);
    
    %baricenter
    ext(2*ct-1).xb=mean(seg(ct).x(1:npbr));
    ext(2*ct).xb=mean(seg(ct).x(ssegct-npbr+1:ssegct));
    ext(2*ct-1).yb=mean(seg(ct).y(1:npbr));
    ext(2*ct).yb=mean(seg(ct).y(ssegct-npbr+1:ssegct));

    %direction
    d=vtorient2(seg(ct).y(1:npdr),seg(ct).x(1:npdr));
%     if atan2(seg(ct).y(1)-ext(2*ct-1).yb,seg(ct).x(1)-ext(2*ct-1).xb)>0,
%         if d<0, d=d+pi; end;
%     else
%         if d>0, d=d-pi; end;
%     end;
    if angdiff(d,atan2(seg(ct).y(1)-ext(2*ct-1).yb,seg(ct).x(1)-ext(2*ct-1).xb))>pi/2,
        d=d+pi;
    end;
    if d>pi, d=d-2*pi; end;
    ext(2*ct-1).dir=d;
    d=vtorient2(seg(ct).y(ssegct-npdr+1:ssegct),seg(ct).x(ssegct-npdr+1:ssegct));
%     if atan2(seg(ct).y(ssegct)-ext(2*ct).yb,seg(ct).x(ssegct)-ext(2*ct).xb)>0,
%         if d<0, d=d+pi; end;
%     else
%         if d>0, d=d-pi; end;
%     end;
    if angdiff(d,atan2(seg(ct).y(ssegct)-ext(2*ct).yb,seg(ct).x(ssegct)-ext(2*ct).xb))>pi/2,
        d=d+pi;
    end;
    if d>pi, d=d-2*pi; end;
    ext(2*ct).dir=d;
    
    %original segment
    ext(2*ct-1).oseg=ct;
    ext(2*ct).oseg=ct;

    %incompatibility
    ext(2*ct-1).inc=2*ct;
    ext(2*ct).inc=2*ct-1;
    
end;

if dbf, disp('Finished RETextrema'); end;
    