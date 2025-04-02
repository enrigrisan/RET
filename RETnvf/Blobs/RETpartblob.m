%RETPARTBLOB separates blobs.
%   XBP = RETPARTBLOB(XB,XP,OPTIONS.[ORD,STEP,W,MAXFC,TYPE],DBF) computes an image with
%   the original blobs separated, each labelled with a differen integer
%   XB is a binary image representing the blobs 
%   XP is the posterior probability image of the blobs.
%   Regions are determined by a firs median filtering, of order ORD
%   of the original image XP. With subsequent thresholding, with uniformly
%   spaced (with step STEP) thresholds the local maxima are determined.
%   These are then dilated by a square structuring element of dimension 3
%   W is the parameter setting the deepness of the boundary region 
%   among two adjacent blobs, for the possible fusion operation. 
%   MAXFC is the threshold value for the fusion operation
%
%   XSP is the seed points image  
%   XGS is the dilated seed points image, obtained from XSP.
%
%   ADL 2001-02-09.
%   EG  2001-04-27

function [xbp]=RETpartblob(xb,xp,options,dbf)
ord=options.ord;
step=options.step;
w=options.w;
if options.type
   maxfc=options.maxfcwhite;
else
   maxfc=options.maxfcdark;
end

label=bwlabel(xb);
maxblob=max(max(label));
strmaxblob=num2str(maxblob);

if dbf,
   disp('Inside RETpartblob'),
   disp(['Blobs in: ',strmaxblob]),
end

xbp=zeros(size(xb));
xsp=xbp;
xgs=xsp;

for ct1=1:maxblob 
   if dbf, 
      disp(' '),disp(['Analyzing blob ',num2str(ct1),' of ',strmaxblob]); 
   end
   [xbi,r,c]=RETminroi(label==ct1,dbf);
   ranger=[r(1):r(2)];
   rangec=[c(1):c(2)]; 
   xpi=xp(ranger,rangec).*xbi;
   
   %Separation
   xspi=RETseedpoint(xpi,ord,step,dbf);
   if max(max(xspi))>1
      xgsi=RETgrowseed(xbi,xspi,dbf);
   else
      xgsi=xbi;
   end;
   
   %Possible fusion
   if max(max(xgsi))>1
      xfbi=RETfuseblob(xgsi,xpi,w,maxfc,dbf);
   else
      xfbi=xgsi;
   end
    
   xbp(ranger,rangec)=xbp(ranger,rangec)+(xfbi+max(max(xbp))).*(xfbi>0);
   xsp(ranger,rangec)=xsp(ranger,rangec)+(xspi+max(max(xsp))).*(xspi>0);
   xgs(ranger,rangec)=xgs(ranger,rangec)+(xgsi+max(max(xgs))).*(xgsi>0);
end

if dbf
   disp(['Blobs out: ',num2str(max(max(xbp)))])
   disp('Finished RETpatblob')
end



