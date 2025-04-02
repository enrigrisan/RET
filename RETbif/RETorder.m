function sego=RETorder(seg,bif,xod,yod,dbf);

if dbf, disp('Inside RETorder'); end;

sego=seg;

sseg=length(seg);

for ct=1:sseg,
    sego(ct).o=0;
end;

ef=0;
while ~ef,
    
    mindist=1e6;
    imin=0;
    for ct=1:sseg,
        if ~sego(ct).o,
            d1=(seg(ct).x(1)-xod)^2+(seg(ct).y(1)-yod)^2;
            d2=(seg(ct).x(length(seg(ct).x))-xod)^2+(seg(ct).y(length(seg(ct).y))-yod)^2;
            mind=min(d1,d2);
            if mind<mindist,
                imin=ct;
                mindist=mind;
            end;
        end;
    end;
    
    if imin,
        sego(imin).o=1;
        sego=propagate(sego,bif);
    else
        ef=1;
    end;
end;

if dbf, disp('Finished RETorder'); end;

function sego=propagate(seg,bif);

sbif=length(bif);

ef=0;

while ~ef,
    
    ef2=0;
    ct=1;
    while ~ef2,
        if seg(bif(ct).i(1)).o>0,
            if ~seg(bif(ct).i(2)).o,
                seg(bif(ct).i(2)).o=seg(bif(ct).i(1)).o+1;
                ef2=1;
            end;
            if ~seg(bif(ct).i(3)).o,
                seg(bif(ct).i(3)).o=seg(bif(ct).i(1)).o+1;
                ef2=1;
            end;
        else
            if seg(bif(ct).i(2)).o>0,
                if ~seg(bif(ct).i(1)).o,
                    seg(bif(ct).i(1)).o=seg(bif(ct).i(2)).o+1;
                    ef2=1;
                end;
                if ~seg(bif(ct).i(3)).o,
                    seg(bif(ct).i(3)).o=seg(bif(ct).i(2)).o+1;
                    ef2=1;
                end;
            else
                if seg(bif(ct).i(3)).o>0,
                    if ~seg(bif(ct).i(1)).o,
                        seg(bif(ct).i(1)).o=seg(bif(ct).i(3)).o+1;
                        ef2=1;
                    end;
                    if ~seg(bif(ct).i(2)).o,
                        seg(bif(ct).i(2)).o=seg(bif(ct).i(3)).o+1;
                        ef2=1;
                    end;
                end;
            end;
        end;
        if ~ef2,
            ct=ct+1;
            ef2=ct>sbif;
            ef=ef2;
        end;
    end;
end;

sego=seg;
