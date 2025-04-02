function [segbif,bif]=RETbif(seg,extpar,splitpar,bifpar,dbf);

if dbf, disp('Inside RETbif'); end;

ext=RETextrema(seg,extpar.npd,extpar.npb,dbf);

segbif=RETsplit(seg,ext,splitpar.minorder,splitpar.mindist,dbf);

ext=RETextrema(segbif,extpar.npd,extpar.npb,dbf);
sext=length(ext);



xe=zeros(sext,1);
ye=zeros(sext,1);
for ct=1:sext;
    xe(ct)=ext(ct).xe;
    ye(ct)=ext(ct).ye;
end;
distm=distmatrix([xe,ye],[xe,ye]);

[i1,i2]=find(distm<=bifpar.mindist);
si1=length(i1);

dv=[];
for ct1=1:si1,
    e1=i1(ct1);
    e2=i2(ct1);
    v1=distm(:,e1)<=bifpar.mindist;
    v2=distm(:,e2)<=bifpar.mindist;
    i3=find(v1&v2);
    si3=length(i3);
    for ct2=1:si3
        e3=i3(ct2);
        p=~(ext(e1).inc==e2|ext(e1).inc==e3|ext(e2).inc==e1|ext(e2).inc==e3|ext(e3).inc==e1|ext(e3).inc==e2);
        p=p&~(e1==e2|e2==e3|e3==e1);
        if p,
            dv=[dv;e1,e2,e3,distm(e1,e2)+distm(e2,e3)+distm(e3,e1)];
        end;
    end;
end;

% distm=ones(sext,sext,sext)*(bifpar.mindist+1);
%
% for ct1=1:sext-1,
%     ct1/sext
%     for ct2=ct1+1:sext-1
%         for ct3=ct2+1:sext
%             p=~(ext(ct1).inc==ct2|ext(ct1).inc==ct3|ext(ct2).inc==ct1|ext(ct2).inc==ct3|ext(ct3).inc==ct1|ext(ct3).inc==ct2);
%             p=p&~(ct1==ct2|ct2==ct3|ct3==ct1);
%             if p,
%                 s=(ext(ct1).xe-ext(ct2).xe)^2+(ext(ct1).ye-ext(ct2).ye)^2;
%                 if s<bifpar.mindist,
%                     s=s+(ext(ct2).xe-ext(ct3).xe)^2+(ext(ct2).ye-ext(ct3).ye)^2;
%                     if s<bifpar.mindist,
%                         s=s+(ext(ct3).xe-ext(ct1).xe)^2+(ext(ct3).ye-ext(ct1).ye)^2;
%                         distm(ct1,ct2,ct3)=s;
%                     end;
%                 end;
%             end;
%         end;
%     end;
% end;

extcheck=zeros(sext,1);
bif=[];

ef=length(dv)==0;
while ~ef,
    %mindist=min(min(min(distm)))
    mindist=min(dv(:,4));
    if mindist<=bifpar.mindist,
        %[ct1,ct2,ct3]=findminimum(distm,mindist);
        %         ct1=ct1(1)
        %         ct2=ct2(1)
        %         ct3=ct3(1)
        %distm(ct1,ct2,ct3)=bifpar.mindist+1;
        i=find(dv(:,4)==mindist);
        i=i(1);
        ct1=dv(i,1);
        ct2=dv(i,2);
        ct3=dv(i,3);
        dv(i,4)=bifpar.mindist+1;
        if ~(extcheck(ct1)|extcheck(ct2)|extcheck(ct3)),
            extcheck(ct1)=1;
            extcheck(ct2)=1;
            extcheck(ct3)=1;
            nbif.i=[ext(ct1).oseg,ext(ct2).oseg,ext(ct3).oseg];
            nbif.x=[ext(ct1).xe,ext(ct2).xe,ext(ct3).xe];
            nbif.y=[ext(ct1).ye,ext(ct2).ye,ext(ct3).ye];
            nbif.dir=[ext(ct1).dir,ext(ct2).dir,ext(ct3).dir];
            bif=[bif;nbif];
        end;
    else
        ef=1;
    end;
end;


if dbf, disp('Finished RETbif'); end;

function [i1,i2,i3]=findminimum(dm,m);
s=size(dm,1);


i1=0;
i2=0;
i3=0;

ef=0;
ct1=1;
while (ct1<=s)&~ef    
    ct2=1;
    while (ct2<=s)&~ef
        ct3=1;
        while (ct3<=s)&~ef
            if dm(ct1,ct2,ct3)==m,
                i1=ct1;
                i2=ct2;
                i3=ct3;
                ef=1;
            else
                ct3=ct3+1;
            end;
        end;
        ct2=ct2+1;
    end;
    ct1=ct1+1;
end;

