function [xself,yself,diamself]=RETBfilter(xsel,ysel,diamsel,dbf);
if dbf, disp('>>> Inside RETBfilter'); end;

%hough quantization parameters
nrho=256;
ntheta=256;

%hough filtering tolerance
tol=[0.2,2];

[hores,xo,yo]=RETBhough(xsel,ysel,nrho,ntheta,dbf);
[xself,yself,diamself]=RETBdehough(hores,xo,yo,xsel,ysel,diamsel,tol,dbf);

if dbf,
   h=gcf;
   figure;
   subplot(1,2,1);
   plot(xsel,-ysel,'rx');
   title('Original points');
   subplot(1,2,2);
   plot(xself,-yself,'rx');
   title('Filtered points');
   figure(h);
end;

if dbf, disp('>>> Finished RETBfilter'); end;
