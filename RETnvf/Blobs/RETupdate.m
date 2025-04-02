function [newboundary,newisnear,newfc]=RETupdate(boundary,isnear,fc,i,j,xbf,w,xp,dbf)
%RETUPDATE Updates boundary regions and fusion coefficients.

if dbf, disp('Inside RETupdate'); end

%Updates adjacent
isnear(i,j)=0; 
isnear(j,i)=0;
isnear(i,:)=isnear(i,:) | isnear(j,:);
isnear(:,i)=isnear(:,i) | isnear(:,j);
isnear(j,:)=[]; 
isnear(:,j)=[];

%Updates boundaries and fusion coeff.
boundary(j,:)=[]; 
boundary(:,j)=[];  
fc(:,j,:)=[];
fc(j,:,:)=[];
for ct1=1:size(isnear,2)
   if isnear(i,ct1) 
      %Updates boundaries
      r=min([sum(sum(xbf==i))/pi,sum(sum(xbf==ct1))/pi].^0.5);
      boundary(i,ct1)=RETboundaryregion(xbf==i,xbf==ct1,round(r*w),dbf);
      boundary(ct1,i)=boundary(i,ct1);
      
      %Updates fusion coeff.
      fc(i,ct1,:)=RETfusecoeff(xbf,xp,i,ct1,boundary(i,ct1),dbf);
      fc(ct1,i,:)=fc(i,ct1,:);
   end
end
  
newboundary=boundary;
newisnear=isnear;
newfc=fc;

if dbf, disp('Finished RETupdate'); end
