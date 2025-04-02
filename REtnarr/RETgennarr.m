function [narr,d]=RETgennarr(sega,coeff,dbf);

if dbf, disp('Inside RETgennarr'); end;

d=[];
for ct=1:length(sega),
   d=[d;sega(ct).d];
end;

m=exp(mean(log(d)));

narr=m/coeff;

if dbf, disp('Finished RETgennarr'); end;

   