function h=simshow(i,f)
if nargin<2,
   dimi=size(i);
	fv=fix(dimi/10);
	i=i-min(min(i(fv(1):dimi(1)-fv(1),fv(2):dimi(2)-fv(2))));
   i=i/max(max(i(fv(1):dimi(1)-fv(1),fv(2):dimi(2)-fv(2))));
else
   i=i-min(min(i));
   i=i/max(max(i));
end;
h=imshow(i);