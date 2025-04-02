function nvf=RETnvffeatures(xb,xc,xp,options,dbf)

%RETNVFFEATURES Extracts blobs features.
%   NVF = RETPATFEATURES(XB,XC,XP,OPTIONS,DBF) determines the feaures
%   of blobs in XB. XB is the grayscale blobs image, each blob
%   characterised by a different integer number. 
%   XB has dimension [R,C].
%   XC is the isoenlighted RGB image, whose dimensions: [R,C,3]
%   XP is the blob probability image, whose dimensions are [R,C].
%   OPTIONS: structure with fields: [WC, TYPE] 
%   			WC is a parameter determining the border region 
%         TYPE is a flag indicating the tyoe of sign to be 
%         analysed: TYPE= 1 for white pathologic sign, TYPE=0
%				for dark ones
%   DBF debug flag.
%   NVF is a matrix with blobs on the rows and features on the columns 
%   
%   Default: WC = 1/2;
%
%   ADL 2001-03-19
%   EG  2001-05-21

if dbf, disp('Inside RETnvffeatures'); end

numblob=max(max(xb));

if(numblob>0)
for ct1=1:numblob
   %if dbf, 
   disp([' Analyzing blob ',num2str(ct1),' of ',num2str(numblob)]); 
   %end
   [xpat,r,c]=RETminroienh(xb==ct1,dbf);
   xcpat=xc(r(1):r(2),c(1):c(2),:);
   xppat=xp(r(1):r(2),c(1):c(2));
   nvf(ct1,:)=RETfeat(xpat,xcpat,xppat,options,dbf);
end
else
	nvf=[];
end;
if dbf, disp('Finished RETnvffeatures'); end
