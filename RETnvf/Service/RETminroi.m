% RETMINROI  Selects the minimum region of interest
%   [ROI,RROI,CROI] = RETMINROI(BW) returns the smallest
%   matrix contatinig the object BW
%
%   ADL 2001-03-12.
%   EG  2001-06-11

function [roi,rroi,croi]=RETminroi(bw,dbf);

if dbf, disp('Inside RETminroi'); end;
[r,c]=find(bw);
r1=min(r); c1=min(c);
r2=max(r); c2=max(c);

rroi=[r1,r2];
croi=[c1,c2];
roi=double(bw(r1:r2,c1:c2));
if dbf, disp('Finished RETminroi'); end;











