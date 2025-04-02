function [boundary,isnear,fc]=boundarycoeff(xb,xp,w,dbf)

%RETboundarycoeff Determines the boundary region and the fusion coefficients.
%   [BOUNDARY,ISNEAR,FC,]=RETboundarycoeff(XB,XP,W,DBF) 
%   BOUNDARY is a struct matrix with field "ind" containing the indexes of the
%   boundary region of adjacent blobs. 
%   ISNEAR is a binary matrix of dimension N x N, with N the number of different
%   blobs present in XB. ISNEAR(i,j)=1 if blobs XB==i e XB==j sare adjacent,
%   zero otherwise. 
%   FC is the fusion coeff. matrix of dimension dimensione N x N x L 
%   where L is the number of coeff. involved in the fusion operation.
%
%   EG 2001-04-27

if dbf, disp('Inside RETboundarycoeff'); end

maxblob=max(max(xb));
isnear=zeros(maxblob);
fc=[];

for ct1=1:maxblob
   for ct2=ct1+1:maxblob
      %r=min((Area_i,Area_j)/pi)^0.5/
      r=min([sum(sum(xb==ct1))/pi,sum(sum(xb==ct2))/pi].^0.5);
      
      isnear(ct1,ct2)=bweuler(bwfill((xb==ct1)|(xb==ct2),'holes'))==1;
      isnear(ct2,ct1)=isnear(ct1,ct2);
      
      if isnear(ct1,ct2) 
         boundary(ct1,ct2)=RETboundaryregion(xb==ct1,xb==ct2,round(r*w),dbf);
         boundary(ct2,ct1)=boundary(ct1,ct2);
         
         fc(ct1,ct2,:)=RETfusecoeff(xb,xp,ct1,ct2,boundary(ct1,ct2),dbf);
         fc(ct2,ct1,:)=fc(ct1,ct2,:);
      end
   end
end

if dbf, disp('Finished RETboundarycoeff'); end
