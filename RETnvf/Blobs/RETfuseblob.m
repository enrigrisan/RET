%RETFUSEBLOB fuses adjacent blobs.
%   XBF = RETfuseblob(XB,XP,W,MAXFC,DBF)
%   XB is an image in which different blobs are characterized by  
%   different integer numbers.
%   Fusion operation is carried out based on the posterior probability
%   image of the blobs XP, and on the boundary region among the 
%   adjacent ones
%   W sets the width of the boundary region: let Ai and Aj be the areas 
%   of two afjacent blobs i,j, the width is determined by the fraction W 
%   of the radius of a virtual circle with area min(Ai,Aj).
%   MAXFC is the maximum admitted values for the fusion coefficients to
%   proceed with a fusion.
%
%   ADL 2001-04-06.
%   EG  2001-04-27

function xbf=RETfuseblob(xb,xp,w,maxfc,dbf)

if dbf, disp('Inside RETfuseblob'); end

%Determines the boundary region
[boundary,isnear,fc]=RETboundarycoeff(xb,xp,w,dbf);
xbf=xb;
[fec,i,j]=RETexitcondition(fc,isnear,maxfc,dbf);

while ~fec
   xfuse=or(xbf==i,xbf==j);
   x1=(xbf.*(~xfuse)+ i*xfuse).*(xbf<=j);
   x2=(xbf-1).*(xbf>j);
   xbf=x1+x2;
   [boundary,isnear,fc]=RETupdate(boundary,isnear,fc,i,j,xbf,w,xp,dbf);
   [fec,i,j]=RETexitcondition(fc,isnear,maxfc,dbf);
end
   
if dbf, disp('Finished RETfuseblob'); end

   






