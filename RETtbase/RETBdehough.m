function [xself,yself,diamself,rself,thself]=RETBdehough(hores,xo,yo,xsel,ysel,diamsel,tol,dbf);
if dbf, disp('>>> Inside RETBdehough'); end;

szhores=size(hores);

mhores=max(max(hores));
[r,th]=find(hores>(mhores*tol(1)));

if dbf,
   h=gcf;
   sims(hores);
   hold on
   plot(th,r,'or');
   figure(h);
end;

r=(r-szhores(1)/2)*(max([max(xsel);max(ysel)])-min([min(xsel);min(ysel)]))/szhores(1);
th=th*pi/szhores(2);

c=cos(th); 
s=sin(th);

xself=[];
yself=[];
diamself=[];
np=length(r);

for ct=1:length(xsel),
   score=0;
   ctt=1;
   while (ctt<=np)&~score,
      if abs((xsel(ct)-xo)*c(ctt)+(ysel(ct)-yo)*s(ctt)-r(ctt))<tol(2), 
          score=1; 
      end;
      if score, 
         xself=[xself;xsel(ct)];
         yself=[yself;ysel(ct)];
         diamself=[diamself;diamsel(ct)];
      end;
      ctt=ctt+1;
   end;
end

if dbf, disp('>>> Finished RETBdehough'); end;
