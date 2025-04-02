function fc=RETfusecoeff(xb,xp,i,j,boundary,dbf)

if dbf, disp('Inside RETfusecoeff'); end

sxb=size(xb);
xboundary=zeros(sxb);
xboundary(boundary.ind)=1;

indi=find(xb==i&~xboundary);
indj=find(xb==j&~xboundary);

if (length(indi)==0 || length(indj)==0)
    fc=[0,0];
    return;
end;

mi=mean(xp(indi));
mj=mean(xp(indj));
sdi=std(xp(indi));

if(isnan(sdi))
%    keyboard
end;

if ~sdi
   sdi=1;
end

sdj=std(xp(indj));
if(isnan(sdj))
%    keyboard
end;

if ~sdj
   sdj=1;
end
fc(1)=(mi-mj)^2/sdi^2+(mi-mj)^2/sdj^2;

indb=find(xboundary);
if ~isempty(indb)
   mb=mean(xp(indb));
   sdb=RETliminf(std(xp(indb)),dbf);
   [mm,n]=min([mi,mj]);
   sd=[sdi,sdj];
   sdm=sd(n);
   fc(2)=(mm-mb)^2/sdm^2+(mm-mb)^2/sdb^2;
else
   fc(2)=0;
end

if (dbf==1)
   disp([' Fusion coefficients (',num2str(i),',',num2str(j),')----> ',num2str([fc])])
   disp('Finished RETfusecoeff')
end
