function xpv=RETpriorvsl(seg,x,options,dbf)

%RETpriorvsl computes the masked image xpv from the input image x,
%	in which the image has value 1 in correspondence with a vessel,
%	0 otherwise
%	Given the vessel structure SEG, a spline approximation with step STEP 
%	is computed. A circular kernel of diameter equal to W times the vessel 
%	calibre is applied to every vessel barycentre, determining the mask.

if dbf, disp('Inside RETpriorvsl'); end

sx=size(x);
if(~isempty(options.step)),
   step = options.step;
else
   step=1
end;
if(~isempty(options.w)),
   w=options.w;
else
  w=1.5;
end;

xpv=zeros(sx);
for ct1 = 1:length(seg),      
   c = fnval( seg(ct1).ppx,[ seg(ct1).ppx.breaks(1):step:seg(ct1).ppx.breaks(end) ]);
   r = fnval( seg(ct1).ppy,[ seg(ct1).ppy.breaks(1):step:seg(ct1).ppy.breaks(end) ]);
   d = fnval( seg(ct1).ppd,[ seg(ct1).ppd.breaks(1):step:seg(ct1).ppd.breaks(end) ])/2;
   
   r=round(r);
   c=round(c);
   d=round(d*w);
   for ct2=1:length(r)
      sets.r=d(ct2);
      sets.center=[];
      sets.dim=[];
      xpv(r(ct2)-d(ct2):r(ct2)+d(ct2),c(ct2)-d(ct2):c(ct2)+d(ct2))=...
         xpv(r(ct2)-d(ct2):r(ct2)+d(ct2),c(ct2)-d(ct2):c(ct2)+d(ct2))|RETcirck(sets,dbf);
   end
end
xpv=double(xpv);

if dbf, disp('Finished RETpriorvsl'); end