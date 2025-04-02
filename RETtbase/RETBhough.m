function [hores,xo,yo]=RETBhough(x,y,nrho,ntheta,dbf);
if dbf, disp('>>> Inside RETBhough'); end;

xo=(max(x)+min(x))/2;
yo=(max(y)+min(y))/2;
d_rho=(max([max(x);max(y)])-min([min(x);min(y)]))/nrho;
d_theta=pi/ntheta;
theta=0:d_theta:pi-d_theta;
smat=sin(theta);
cmat=cos(theta);

h=((y-yo)*smat+(x-xo)*cmat)/d_rho;
h=round(h+nrho/2);
hores=zeros(nrho,ntheta);
for j=0:nrho-1
    hores(j+1,:)=sum(h==j);
end

if dbf, disp('>>> Finished RETBhough'); end;
