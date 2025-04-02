% FRK
% gets a roi from an image
% if a title is specified it is written on top of the ROIui figure

function [xroi,rroi,croi]=getroi(x,tit);
h=figure;
simshow(x);
if nargin>1, title(tit); end;
[xroi,yroi]=ginput(2);
close(h)
rroi=fix(yroi);
croi=fix(xroi);
%rroi=rroi-(size(x,1)-rroi).*(rroi>size(x,1))
%rroi=rroi-(rroi-1).*(rroi<=0)
%croi=croi-(size(x,2)-croi).*(croi>size(x,2))
%croi=croi-(croi-1).*(croi<=0)
xroi=x(rroi(1):rroi(2),croi(1):croi(2));
