function [xsel,ysel,lvsel]=RETBgetbub(x,xc,yc,r,bth,vcmin,del,split,dbf);
if dbf, disp('>>> Inside RETBgetbub'); end;

%debug for RETscan activation flag
dbfint=dbf;

[xsel,ysel,lvsel,v]=RETscan(x,bth,xc,yc,r,fix(2*pi*r/(2*split))*2,0,2*pi,del(1),vcmin,0,dbfint);

if size(xsel,1)<size(xsel,2) 
   xsel=xsel';
   ysel=ysel';
   lvsel=lvsel';
end;

ic=find(lvsel<=del(2));
xsel=xsel(ic);
ysel=ysel(ic);
lvsel=lvsel(ic);

%no need since lv is not returned
%lv=ysel(ic);

%
%missing check on del(3) ---> minimum number of non-vessel pixels allowed
%

if dbf, disp('>>> Finished RETBgetbub'); end;
