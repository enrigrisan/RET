function xr=hipass(x,n);
xr=x-filter2(ones(n)/(n^2),x,'same');