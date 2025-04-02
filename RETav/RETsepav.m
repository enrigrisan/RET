function segart=RETsepav(seg,thp,dbf);

if dbf, disp('Inside RETsepav'); end;

cta=1;
for ct=1:length(seg),
   if max(seg(ct).pav)==seg(ct).pav(3),
      segart(cta)=seg(ct);
      cta=cta+1;
   end;
end;

if dbf, disp('Finished RETsepav'); end;