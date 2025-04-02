function [rseeds,seedse]=RETcutseed4(seg,seeds,dmin,dbf)

dmin=dmin^2;
if(isempty(seeds))
    rseeds=[];
    seedse=[];
    return;
end;

try
    [x,y,d,dir]=RETseedsextract(seeds,dbf);
catch
    keyboard;
end;
seedse=[];

lseg=length(seg);

for ct2=1:lseg,
    xv=seg(ct2).x;
    yv=seg(ct2).y;

    xocc=[min(xv),max(xv)];
    yocc=[min(yv),max(yv)];
    docc=(x>=xocc(1))&(x<=xocc(2))&(y>=yocc(1))&(y<=yocc(2));
    i=find(docc);

    rseeds=seeds(find(~docc));
    si=length(i);
    for ct=1:si,
        d=(seeds(i(ct)).x-xv).^2+(seeds(i(ct)).y-yv).^2;
        if any(d<=dmin),
            seedse=[seedse,seeds(i(ct))];
        else
            rseeds=[rseeds,seeds(i(ct))];
        end;
    end;
end;