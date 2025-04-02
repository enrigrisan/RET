function [seedr]=RETrecoverseed(seede,xv,yv,dmin,dbf)

if dbf, disp('Inside RETrecoverseed'); end;

dmin=dmin^2;

[x,y,d,dir]=RETseedsextract(seede,dbf);

sxv=length(xv);
s=(((x-xv(1)).^2+(y-yv(1)).^2)<dmin)|(((x-xv(sxv)).^2+(y-yv(sxv)).^2)<dmin);
i=find(s);
seedr=seede(i);

if dbf, disp('Finished RETrecoverseed'); end;
