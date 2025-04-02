function segnew=RETsplit(seg,ext,minorder,mindist,dbf);

sseg=length(seg);
sext=length(ext);

%initialisation of extrema coordinates vector vext and incompatibility vector vinc
vext=[];
vinc=zeros(sext,1);
for ct=1:sext,
    vext=[vext;ext(ct).xe,ext(ct).ye];
    %vinc(ct)=ext(ct).inc;
end;


% extraction of cutting condition for every segment
% dmatrix: cutting condition boolean matrix 
% cimatrix: cut index matrix, contains the cut index in the seg structure
%           for the ext,seg combination

dmatrix=zeros(sext,sseg);
cimatrix=zeros(sext,sseg);
for ct=1:sseg,
    dm=distmatrix(vext,[seg(ct).x,seg(ct).y]);
    dv=min(dm')';
    oinc=zeros(sext,1);
    for ct2=1:sext,
        i=find(dm(ct2,:)==dv(ct2));
        i=i(1);
        cimatrix(ct2,ct)=i;
        if min(length(seg(ct).x)-i+1,i)<minorder,
            oinc(ct2)=1;
        end;
    end;
    %dmatrix(:,ct)=(dv<(mindist^2))&(vinc~=ct)&(~oinc);
    dmatrix(:,ct)=(dv<(mindist^2))&(vinc~=ct)&(~oinc);
end;

%check segments that can be cut
[iext,iseg]=find(dmatrix);

%perform cuts
if length(iseg),
    [iseg,i]=sort(iseg);
    iext=iext(i);
    
    si=length(iext);
    segnew=[];
    
    for ct=1:sseg,
        i=find(iseg==ct);
        if length(i),
            iextsel=iext(i);
            siextsel=length(iextsel);
            civ=zeros(siextsel,1);
            for ct2=1:siextsel,
                civ(ct2)=cimatrix(iextsel(ct2),ct);
            end;
            [civ,i]=sort(civ);
            %iextsel=iextsel(i);
            oci=1;
            segel=[];
            ns=seg(ct);
            for ct2=1:siextsel,
                if (civ(ct2)-oci)>minorder,
                    ns.x=seg(ct).x(oci:civ(ct2));
                    ns.y=seg(ct).y(oci:civ(ct2));
                    ns.d=seg(ct).d(oci:civ(ct2));
                    ns.dir=seg(ct).dir(oci:civ(ct2));
                    if ct2==1,
                        ns.ec=[seg(ct).ec(1);300];
                    else
                        ns.ec=[300;300];
                    end;
                    segel=[segel,ns];
                    oci=civ(ct2)+1;
                end;
            end;
            ns.x=seg(ct).x(oci:end);
            ns.y=seg(ct).y(oci:end);
            ns.d=seg(ct).d(oci:end);
            ns.dir=seg(ct).dir(oci:end);
            ns.ec=[300;seg(ct).ec(2)];
            segel=[segel,ns];
            segnew=[segnew,segel];
        else
            segnew=[segnew,seg(ct)];
        end;
    end;
else
    segnew=seg;
end;
