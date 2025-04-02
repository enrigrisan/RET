function xr=nmlz2(x);
sd=std2(x);
m=mean2(x);
nsd=2.5;
xr=x-m+nsd*sd;
xr=(xr>0).*xr;
xr=xr/(2*nsd*sd);
xr=(xr<=1).*xr+(xr>1);