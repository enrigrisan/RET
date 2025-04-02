function [seedr]=RETrecoverseed(seede,seg,dmin,dbf)

if dbf, disp('Inside RETrecoverseed'); end;

dmin=dmin^2;

[x,y,d,dir]=RETseedsextract(seede,dbf);

seedr=[];

lseg=length(seg);
for ct=1:lseg,
    xv=seg(ct).x;
    yv=seg(ct).y;
    sxv=length(xv);
    s=(((x-xv(1)).^2+(y-yv(1)).^2)<dmin)|(((x-xv(sxv)).^2+(y-yv(sxv)).^2)<dmin);
    i=find(s);
    seedr=[seedr,seede(i)];
end;

if dbf, disp('Finished RETrecoverseed'); end;
