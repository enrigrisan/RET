function [fec,i,j]=RETexitcondition(fc,isnear,maxcf,dbf)

%RETEXITCONDITION Determines the ending of the fusion cycle.
%   [FEC,I,J]=RETEXITCONDITION(FC,ISNEAR,THEC,DBF) 
%   FEC=0 tells that there's some blobs to be fused and I,J are the
%   indices of the blobs to be processed
%
%   EG 2001-04-27

if dbf, disp('Inside RETexitcondition'); end

i=0;
j=0;
fec=1;

[r,c]=find(triu(isnear));
a1=inf;
for ct1=1:length(r)
   coeff=fc(r(ct1),c(ct1),:);
   a2=sqrt(sum(coeff.^2));
   if(a1>a2)&(a2<=maxcf)
      a1=a2;
      fec=0;
      i=r(ct1);j=c(ct1);
   end
end
if dbf
   if ~fec
      disp([' Best blobs for fusion: (',num2str(i),',',num2str(j),')'])
      disp([' Fusion coefficient:     ',num2str(a1)])
   else
      disp(' No blobs for fusion')
   end
   disp('Finished RETexitcondition')
end
