%RETBOUNDARYREGION Determines the boundary regions among adjacent blobs.
%   B = RETBOUNDARYREGION(XBI,XBJ,DMAX) 
%   B is a structure containing the boundary pixel indexes.
%   DMAX set the maximum admitted distance among pixels pertaining 
%   to different objects and to the boundary region
%
%   ADL 2001-04-06.
%   EG  2001-04-27

function boundary=RETboundaryregion(xbi,xbj,dmax,dbf)

if dbf, disp('Inside RETboundaryregion'); end

[ri,ci]=find(xbi);
[rj,cj]=find(xbj);
sxbi=size(xbi);
boundary=struct('ind',[]);
tmp=zeros(sxbi);

lrj=length(rj);
lcj=length(cj);
for ct1=1:length(ri)
   di=min(((ri(ct1)-rj).^2 +(ci(ct1)-cj).^2).^0.5);
   if di<=dmax
      tmp(ri(ct1),ci(ct1))=1;
   end
end
lri=length(ri);
lci=length(ci);
for ct2=1:size(rj);
   dj=min(((rj(ct2)-ri).^2 +(cj(ct2)-ci).^2).^0.5);
   if dj<=dmax
      tmp(rj(ct2),cj(ct2))=1;
   end 
end

boundary.ind=find(tmp);

if dbf, disp('Finished RETboundaryregion'); end
