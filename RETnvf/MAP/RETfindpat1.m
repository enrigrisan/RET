function [xpdf,xpdfcl]=RETfindpat1(xft,xpp,pdf,dbf)

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
m=pdf(1).m;
spdf=length(pdf);
%sd=pdf.sd;
%a=pdf.a;
%n=pdf.n;

% xpdfft(:,:,i) pd image of the i-th feature 
% xpdfcl(:,:,i) pd image of the i-th class
% xpdf          unconditioned pd image
% xpcl(:,:,i)   posterior probability image of th i-th class


sm=size(m);
sxft=size(xft);
xpdf=zeros(sxft(1),sxft(2));

for ct1=1:spdf%run through the classes
if dbf, disp(vis{ct1}); end
xpdfft=zeros(sxft(1),sxft(2));
%xg=zeros(1,length(x));
for ct3=1:sm(1),%run trhu the modes
   v=pdf(ct1).cov(:,:,ct3);
   m1=pdf(ct1).m(ct3,:);
   iv=inv(v);
   den=(1/(sqrt((2*pi)^3*det(iv))));
   for ctx=1:sxft(1),
      for cty=1:sxft(2),
         x(1,1:3)=xft(ctx,cty,:);
         xpdfft(ctx,cty)=xpdfft(ctx,cty)+den*exp(-0.5*((x-m1)*iv*(x-m1)'));
      end;
   end;
end;
   xpdf=xpdf+xpdfft.*xpp(:,:,ct1);
   xpdfcl(:,:,ct1)=xpdfft;
end

if dbf, disp('Finished RETfindpat'); end





