function segnew=RETlinkp(seg,ext,dcoeff,acoeff,minscore,dbf)

if dbf, disp('Inside RETlink'); end;

sext=length(ext);

%distance matrix generation
xe=zeros(sext,1);
ye=zeros(sext,1);
for ct=1:sext;
    xe(ct)=ext(ct).xe;
    ye(ct)=ext(ct).ye;
end;
distm=distmatrix([xe,ye],[xe,ye]);

%angdiff matrix generation
angdiff=RETangdiff(ext,dbf);

%compatibility matrix
compmatrix=ones(sext);
for ct=1:sext,
    compmatrix(ct,ct)=0;
    compmatrix(ct,ext(ct).inc)=0;
end;

%score matrix generation
smatrix=exp((-distm./dcoeff)+(-angdiff./acoeff)).*compmatrix;

ef=0;

%decision cycle
mergext=[];
while ~ef,
    mscore=max(max(smatrix));
    if mscore>minscore,
        [i1,i2]=find(smatrix==mscore);
        i1=i1(1);
        i2=i2(1);
        mergext=[mergext;i1,i2];
        smatrix(i1,:)=0;
        smatrix(i2,:)=0;
        smatrix(:,i1)=0;
        smatrix(:,i2)=0;
    else
        ef=1;
    end;
end;
    
%merging cycle;
mergeseg=[];
for ct=1:size(mergext,1),
    mergeseg(ct,1)=ext(mergext(ct,1)).oseg;
    mergeseg(ct,2)=ext(mergext(ct,2)).oseg;
end;

if length(mergeseg),
    segnew=RETsegmergeidp(seg,mergeseg,dbf);
else
    segnew=seg;
end;

if dbf, disp('Finished RETlink'); end;
