function segn=RETcheckoverlap(seg,xv,yv,dirv,dv,ec,dmin,noverlap,dbf)

if dbf, disp('Inside RETcheckoverlap'); end;

if length(seg),
    dmin=dmin^2;
    
    sseg=length(seg);
    sxv=length(xv);
    
    p=ones(sxv,1);
    for ct=1:sseg,
        sref=length(seg(ct).x);
        xref=seg(ct).x(1:2:sref);
        yref=seg(ct).y(1:2:sref);
        dm=distmatrix([xref,yref],[xv,yv]);    
        p=p&(min(dm)'>dmin);
    end;
    segn=[];
    
    if any(~p),
        ip=find(p);
        ct1=0;
        ct2=0;
        ipo=-1;
        for ct3=1:length(ip),
            if ip(ct3)~=ipo+1,
                ct1=ct1+1;
                ct2=1;
                segn(ct1).ec=[100;100];
            else
                ct2=ct2+1;
            end;
            ipo=ip(ct3);
            segn(ct1).x(ct2,1)=xv(ip(ct3));
            segn(ct1).y(ct2,1)=yv(ip(ct3));
            segn(ct1).d(ct2,1)=dv(ip(ct3));
            segn(ct1).dir(ct2,1)=dirv(ip(ct3));
        end;
%         sims(xroi);
%         hold on;
%         plot(xv,yv,'or');
%         RETdispseg(xroi,seg);
%         RETdispseg(xroi,segn);
%         pause;
%         clall;
        
    else
        segn.x=xv;
        segn.y=yv;
        segn.d=dv;
        segn.dir=dirv;
        segn.ec=ec;
    end;
else
    segn.x=xv;
    segn.y=yv;
    segn.d=dv;
    segn.dir=dirv;
    segn.ec=ec;
end;

if dbf, disp('Finished RETcheckoverlap'); end;

% if dbf,
%     if any(~p),
%         figure;
%         plot(p);
%         pause;
%     end;
% end;
