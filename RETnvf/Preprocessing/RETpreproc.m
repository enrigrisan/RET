%RETPREPROC execute image preprocessing
%   [XISO,XROI] = RETPREPROC(XC,OPTIONS,DBF) gives in the output an
%   isoenlighted image XISO, and the region of interest XROI.
%   XC is the RGB input image, ORD is the order of the square block  
%   used for the drift elimination.
%   M is a vector containing the mean values of the three RGB channel
%   for the output image.
%   SD is the vector containing the standard deviations of the three RGB
%   channel for the output image .
%   WSD is the weight parameter which dets the width of the gray scale range
%   for the free-fundus estimation.
%
%   ADL 2001-04-18.
%   EG  2001-04-27

function [xiso,xroi,xmask]=RETpreproc(xc,options,dbf);

if dbf, disp('Inside RETpreproc'); end

if(~isempty(options.ord)),
   ord=options.ord;
else
   ord=64;
end;
sxc=size(xc);
ord=fix(sqrt((sxc(1)*sxc(2))/(14)^2));
options.ord=ord;
xiso=zeros(sxc);
xmask=zeros(sxc);
xroi=zeros(sxc(1),sxc(2));
[xr,r,c]=RETblkresize(xc,ord,dbf);
xroi=RETfindroi(xc(:,:,1),dbf);
[xiso(r(1):r(2),c(1):c(2),:),xmask(r(1):r(2),c(1):c(2))]=RETdrift(xr,xroi(r(1):r(2),c(1):c(2)),options,dbf);

if dbf, disp('Finished RETpreproc'); end

