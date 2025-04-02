% FRK
% load an image through user interface
% the channels are normalized separately
% gets a ROI if xroin arguments are present

function [x1,x2,x3,pn,fn,xroi1,xroi2,xroi3]=loadimage(spn,sfn);
if nargin<1,
   [fn,pn]=uigetfile('*.*','Image File Name ...');
else
   if nargin<2,
      [fn,pn]=uigetfile([spn,'*.*'],'Image File Name ...');
   else
      pn=spn;
      fn=sfn;
	end;
end;
cfn=[pn,fn];
xo=im2double(imread(cfn));
if size(xo,3)>1 & nargout>1, 
   x1=nmlz(xo(:,:,1)); 
   x2=nmlz(xo(:,:,2)); 
   x3=nmlz(xo(:,:,3)); 
elseif size(xo,3)==1
   x1=nmlz(xo);
   x2=x1;
   x3=x1;
else
    x1=xo;
end;
if nargout>5, 
   [xroi1,rroi,croi]=getroi(x1);
   xroi2=x2(rroi(1):rroi(2),croi(1):croi(2));
   xroi3=x3(rroi(1):rroi(2),croi(1):croi(2));
end;


   
