function [xcl,xpcl]=RETfindpat(xft,xpp,pdf,dbf)

%RETFINDPAT  Classifies the input image pixelwise.
%   [XCL,XPCL] = RETFINDPAT(XFT,XPP,PDF,DBF) gives on the output gray level
%	 image, whose N levels are the N number of considered classes
%   XFT is the prior matrix, whose dimensions are R x C x K.
%   M is the mean matrix, with dimensions K x N x L.
%   M(i,j,t) is the mean of the t-th mode of the probability density
%   function of th j-th class in the i-th feature.
%   SD is the standard deviation matrix, with dimensions K x N x L.
%   SD(i,j,t) is the deviazione standard del t-th mode of the probability density
%   function of th j-th class in the i-th feature.
%   XPP is the prior matrix for every class, with dimension R x C x N 
%   XPCL is the probability matrix of the single classes,
%   with dimensions R x C x K; XPCL(:,:,i) is then the image of
%   the posterior probability of th i-th class.
%
%   ADL 2001-04-06
%   EG 2001-04-27

if dbf, disp('Inside RETfindpat'); end

vis={' Finding Dark Lesions',...
     ' Finding Normal Fundus',...
     ' Finding White Lesions'};
m=pdf.m;
sd=pdf.sd;
a=pdf.a;
n=pdf.n;

% xpdfft(:,:,i) pd image of the i-th feature 
% xpdfcl(:,:,i) pd image of the i-th class
% xpdf          unconditioned pd image
% xpcl(:,:,i)   posterior probability image of th i-th class


sm=size(m);
sxft=size(xft);
xpdf=zeros(sxft(1),sxft(2));

for ct1=1:sm(2)%run through the classes
   if dbf, disp(vis{ct1}); end
   xpdfft=zeros(sxft);
   for ct2=1:sm(1)%run through the features
      for ct3=1:sm(3)
         if(ct1==3),
            thr=a(ct2);
            nor=n(ct2);
         else,
            thr=0;
            nor=0;
         end;
         %xpdfft(:,:,ct2)=xpdfft(:,:,ct2)+(xft(:,:,ct2)>=thr)./(1-nor).*1/sm(3).*(1/(sqrt(2*pi)*sd(ct2,ct1,ct3))).*exp(-((xft(:,:,ct2)-m(ct2,ct1,ct3)).^2/(2*sd(ct2,ct1,ct3)^2)));
         xpdfft(:,:,ct2)=xpdfft(:,:,ct2)+1/sm(3)*(1/(sqrt(2*pi)*sd(ct2,ct1,ct3)))*exp(-((xft(:,:,ct2)-m(ct2,ct1,ct3)).^2/(2*sd(ct2,ct1,ct3)^2)));
      end
   end
   xpdfcl(:,:,ct1)=prod(xpdfft,3);
   xpdf=xpdf+xpdfcl(:,:,ct1).*xpp(:,:,ct1);
end
for ct4=1:sm(2)
   xpcl(:,:,ct4)=(xpdfcl(:,:,ct4).*xpp(:,:,ct4))./xpdf;
end

%MAP
[tmp,xcl]=max(xpcl,[],3);

if dbf, disp('Finished RETfindpat'); end





