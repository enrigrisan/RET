function segr=RETcutsegod(seg,xod,yod,rod,dbf);

if dbf, disp('Inside RETcutsegod'); end;

sseg=length(seg);
segr=[];

for ct=1:sseg,
    sx=length(seg(ct).x);
    d=(seg(ct).x-xod).^2+(seg(ct).y-yod).^2;
    ds=d<(rod^2);
    if any(ds),
        if any(~ds),
            ids=find(ds);
            i1=min(ids);
            i2=max(ids);
            
            if i1>1,
                is1=[1:i1-1];
                nseg=seg(ct);
                nseg.x=seg(ct).x(is1);
                nseg.y=seg(ct).y(is1);
                nseg.dir=seg(ct).dir(is1);
                nseg.d=seg(ct).d(is1);
                segr=[segr;nseg];
            end;
            
            if i2<sx,
                is2=[i2+1:sx];
                nseg=seg(ct);
                nseg.x=seg(ct).x(is2);
                nseg.y=seg(ct).y(is2);
                nseg.dir=seg(ct).dir(is2);
                nseg.d=seg(ct).d(is2);
                segr=[segr;nseg];
            end;
        end;
    else
        segr=[segr;seg(ct)];
    end;
end;

if dbf, disp('Finished RETcutsegod'); end;