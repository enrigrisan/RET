% RETzeromed
% Find the points in the matrix xmi where the value is -1.
% It assigns to this points the mean value of the neighbors selected by a
% circular kernel of radius 1.
% If all the points in the neighborhood are -1, the circular kernel is
% expanded. The process is iterated until a positive value is found.

function xmo=RETzeromed(xmi,dbf);

if dbf, disp('Inside RETzeromed'), end

sxm=size(xmi);
xmo=xmi;
[r,c]=find(xmi==-1);
ct1=1;
ec1=ct1>length(r);
sets.r=[];
sets.center=[];
sets.dim=sxm;

while ~ec1,
   %First try a kernel radius of 1
   ct2=1;
   ec2=0;
   while ~ec2
      sets.r=ct2;
      sets.center=[r(ct1),c(ct1)];
      ind=find((xmi~=-1).*RETcirck(sets,dbf));
      % If no positive values are found in the nearness of [r(ct1),c(ct1)]
      % a greater radius is tried
      if isempty(ind)
         ec2=0;
         ct2=ct2+1;
      else
         m=mean(xmi(ind));
         ec2=1;
      end
   end
   xmo(r(ct1),c(ct1))=m;
   ct1=ct1+1;
   ec1=ct1>length(r);
end

if dbf, disp('Finished RETzeromed'), end
