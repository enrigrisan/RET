function angdiff=RETangdiff(ext,dbf);

if dbf, disp('Inside RETangdiff'); end;

sext=length(ext);

angdiff=zeros(sext);

for ct1=1:sext,
    for ct2=1:sext,
        if ct1==ct2,
            angdiff(ct1,ct2)=pi;
        else
            angbar=atan2(ext(ct2).yb-ext(ct1).yb,ext(ct2).xb-ext(ct1).xb);
            ad=ext(ct1).dir-angbar;
            if ad>pi, ad=ad-2*pi; end;
            if ad<-pi, ad=ad+2*pi; end;
            angdiff(ct1,ct2)=abs(ad);
        end;
    end;
end;

angdiff=angdiff+angdiff';


if dbf, disp('Finished RETangdiff'); end;
