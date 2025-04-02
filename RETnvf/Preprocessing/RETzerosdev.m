% RETzerosdev
% Find the points in the matrix xsdi where the value is -1.
% It assigns to this points the mean value of the neighbors selected by a
% circular kernel of radius 1.
% If all the points in the neighborhood are -1, the circular kernel is
% expanded. The process is iterated until a positive value is found.


function xsdo=RETzerosdev(xsdi,dbf);

if dbf, disp('Inside RETzerosdev'), end

sxm=size(xsdi);
xsdo=xsdi;
[r,c]=find(xsdi<=0);
ct1=1;
ec1=ct1>length(r);
sets.r=[];
sets.center=[];
sets.dim=sxm;

while ~ec1
   ct2=1;
   ec2=0;
   while ~ec2
      %First try a kernel radius of 1
      sets.r=ct2;
      sets.center=[r(ct1),c(ct1)];
      ind=find((xsdi>0).*RETcirck(sets,dbf));
      % If no positive values are found in the nearness of [r(ct1),c(ct1)]
      % a greater radius is tried
      if isempty(ind)
         ec2=0;
         ct2=ct2+1;
      else
         s=mean(xsdi(ind));
         ec2=1;
      end
   end
   % If no allowable value for s is found, the output is set to 1
   if s
      xsdo(r(ct1),c(ct1))=s;
   else 
      xsdo(r(ct1),c(ct1))=1;
   end
   ct1=ct1+1;
   ec1=ct1>length(r);
end

if dbf, disp('Finished RETzerosdev'), end
