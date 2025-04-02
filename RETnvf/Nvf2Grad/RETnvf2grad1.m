%RETNVF2GRAD returns an array of struct containing the features
%   of the lesions found.
%   XBPWHITE is the image of the possible white lesions region. Every region
%   is labeled with a different integer. XBPWHITE has dimensions R x C.
%   XBPDARK is the image of the possible dark lesions region. Every region
%   is labeled with a different integer. XBPWHITE has dimensions R x C.
%   CLWHITE is a column vector of dimension N1, representing containing the clssification
%   a posteriori of every white region described in XBPWHITE.
%   CLWHITE is a column vector of dimension N2, representing containing the clssification
%   a posteriori of every dark region described in XBPDARK.
%   PWHITE is the matrix, of dimensions N1 x 4, containing for every white blob the probability 
%   of it belonging to each of the considered classes.
%   Specifically PWHITE(i,j) is the probability that blob XBPWHITE=i belongs to class j. 
%   PDARK is the matrix, of dimensions N2 x 3, containing for every dark blob the probability 
%   of it belonging to each of the considered classes. 
%   sSpecifically PDARK(i,j) is the probability that blob XBPDARK=i belongs to class j.
%   DBF debug flag.
%   XBLOB is a gray scale image containing all the classified lesions. Every lesion is 
%   identified by a different integer value.
%   NVF is the column vector of structures containing the features of the blobs on xblob. 
%   The fields of every structures are:
%
%         Type:   white or dark pathology 
%         P:      column vector of dimension 4 describing the probability of the blob being:
%                 an haemorrhage 
%                 an exudate
%                 a cotton wool spot
%                 a drusen
%                 a false positive
%         Area:   Lesion area
%         Center: vector with the coordinates row-column of the region center
%
%   ADL 2001-03-15
%   EG  2001-06-11

function [xblob,nvf]=RETnvf2grad(xbpwhite,xbpdark,clwhite,cldark,pwhite,pdark,dbf);

if dbf, disp('Inside RETnvf2grad'), end

sxbpwhite=size(xbpwhite);
xblob=zeros(size(xbpwhite));
blobwhite=max(max(xbpwhite));
blobdark=max(max(xbpdark));
nvf=struct('type',[],'p',[],'area',[],'center',[],'ind',[]);
ct2=1;

for ct1=1:blobwhite
   if dbf,
      disp([' Blob white ',num2str(ct1),' of ',num2str(blobwhite)]);
   end
   [r,c]=find(xbpwhite==ct1);
   ind=sxbpwhite(1)*(c-1)+r;
   switch clwhite(ct1)
      % For white lesions the probability of being dark lesions is always
      % zero
   case 1
      xblob(ind)=ct2;
      nvf(ct2,1).ind=ct1;
      nvf(ct2,1).type='exudate';
      nvf(ct2,1).p=[0;pwhite(ct1,:)'];
      nvf(ct2,1).area=length(ind);
      nvf(ct2,1).center=round([mean(r);mean(c)]);
      ct2=ct2+1;
   case 2
      xblob(ind)=ct2;
      nvf(ct2,1).ind=ct1;
      nvf(ct2,1).type='cws';
      nvf(ct2,1).p=[0;pwhite(ct1,:)'];
      nvf(ct2,1).area=length(ind);
      nvf(ct2,1).center=round([mean(r);mean(c)]);
      ct2=ct2+1;
   case 3
      xblob(ind)=ct2;
      nvf(ct2,1).ind=ct1;
      nvf(ct2,1).type='drusen';
      nvf(ct2,1).p=[0;pwhite(ct1,:)'];
      nvf(ct2,1).area=length(ind);
      nvf(ct2,1).center=round([mean(r);mean(c)]);
      ct2=ct2+1;
   end
end


if dbf, disp('Finished RETnvf2grad'), end
