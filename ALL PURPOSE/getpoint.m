% FRK
% gets a point from an image
% if a title is specified it is written on top of the figure
% if the flag xyf is set, then output is in xy coordinates, otherwise it is in row-column

function [rox,coy,b]=getpoint(x,xyf,tit);
h=figure;
simshow(x);
if nargin==3, title(tit); end;
[xp,yp,b]=ginput(1);
close(h)
rox=fix(yp);
coy=fix(xp);
if nargin>1,
   if xyf,
      rox=xp;
      coy=yp;
   end;
end;
