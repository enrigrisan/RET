function kernel=diffk(kk,k,d,ir,gg);
if ~mod(d,2), d=d+1; end;
dm=fix((d-1)/2);
kernel=isotropk(gg,kk,k,dm,ir)-isotropk(gg,kk+k/2,k,dm,ir);
kernel=kernel/sum(sum(kernel));

