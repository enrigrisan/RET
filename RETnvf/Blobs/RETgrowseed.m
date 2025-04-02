%GROWSEED reconstructs blobs from seed points.
%   XGS = GROWSEED(XB,XSP,DBF) computes an image of the same 
%   dimensions of XB,but with different objects, all related to the same blob
%   XB is the original blob image.
%   XSP is the seed points image.
%   XGS is obtained with iterated dilations starting from the seed points, 
%   using a structuring element SE=ones(3)
%
%   ADL 2001-02-09.
%   EG  2001-04-27

function xgs=RETgrowseed(xb,xsp,dbf)

if dbf, disp('Inside growseed'); end

xgs=xsp;
ec=all(all((xgs>0)==xb));
se=ones(3);

while ~ec
   for ct1=1:max(max(xsp))
      dbi=double(imdilate(xgs==ct1,se) & xb);
      supimp=dbi&((xgs~=ct1).*(xgs>0));
      xgs=xgs.*(xgs~=ct1)+ct1*(dbi & ~supimp);
   end 
   ec=all(all((xgs>0)==xb));
end

if dbf, disp('Finished growseed blob'); end

