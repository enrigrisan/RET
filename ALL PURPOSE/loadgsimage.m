% FRK
% load a gray-scale image through user interface
% gets a ROI if xroi output argument is present

function [xo,xroi,pn,fn]=loadgsimage(spn,ch);
if nargin<1,
   [fn,pn]=uigetfile('*.*','Image File Name ...');
else
   [fn,pn]=uigetfile([spn,'*.*'],'Image File Name ...');
end;
cfn=[pn,fn];
[x,map]=imread(cfn);
xo=double(x);
if length(size(xo))>2, 
   if nargin>1, 
      xo=nmlz(xo(:,:,ch)); 
   else
      xo=nmlz(xo(:,:,2)); 
   end;
end;
if nargout>1, 
   xroi=getroi(xo);
else
   xroi=xo;
end;
