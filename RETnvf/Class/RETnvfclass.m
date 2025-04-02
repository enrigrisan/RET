function [cl,p]=RETnvfclass(ft,options,dbf)

%RETNVFCLASS Blob classifier.
%   [CL,P] = RETNVFCLASS(FT,OPTIONS,DBF) classify the elements with 
%   features vector FT by a minimum distance classifier.
%   The assumption are:
%             Features normally distrubuted
%             Sample space divided in M=3 classes
%   FT is the features matrix in which every column is a vriable and every
%   row a realization. If N is the blob number and K the features
%   FT has dimension [N,K].
%   OPTIONS: structure with field [TYPE,MWHITE,MDARK,KWHITE,KDARK] 
%   TYPE is a flag indicating the tyoe of sign to be 
%        analysed: TYPE= 1 for white pathologic sign, TYPE=0
%			for dark ones
%   MWHITE white pathologic sign means. MWHITE has dimension [(M-1),M] ,
%   MWHITE(i,j) is the mean of the i-th feature in the space conditioned 
%   by the j-th class.
%   MDARK dark pathologic sign means. MWHITE has dimension [(M-1),M] ,
%   MDARK(i,j) is the mean of the i-th feature in the space conditioned 
%   by the j-th class.
%   KWHITE covariance matrix for white pathologic sign. KWHITE has dimensions
%   [(M-1),(M-1),M], KWHITE(i,j,t) is the covariance between the i-th and j-th
%   feature conditioned by class t.
%   KDARK covariance matrix for dark pathologic sign. KWHITE has dimensions
%   [(M-1),(M-1),M], KDARK(i,j,t) is the covariance between the i-th and j-th
%   feature conditioned by class t.
%   DBF è il flag di debug.
%   Cl column vector of diemsion N containing the class of belonging 
%   for every element. CL(i) contains the class of belonging of blobs with 
%   features vector FT(i,:).
%   White pathologic sign
%                       CL = 1    Exudate
%                       CL = 2    Cotton wool
%                       CL = 3    Drusen
%                       CL = 4    False positive
%   Nel caso di patologie scure
%                       CL = 1    Haemorrhage
%                       CL = 2    Vessel
%                       CL = 3    False positive
%   P(i,j) is the probability that the blob with featuers vector FT(i,:) 
%   belongs to class j.
%
%   ADL 2001-06-11
%   EG  2001-06-11

if dbf, disp('Inside RETnvfclass'), end

if options.type
   m=options.mwhite;
   k=options.kwhite;
else
   m=options.mdark;
   k=options.kdark;
end
   
sk=size(k);
sft=size(ft);
       
for ct1=1:sk(3)
   invki=inv(k(:,:,ct1));
   detki=det(k(:,:,ct1));
   mi=m(:,ct1);
   for ct2=1:sft(1)
      x=ft(ct2,:)';
      %Computes the multivariate gaussian pdf for class ct1 of blob ct2 
      pdfx(ct2,ct1)=1/sqrt((2*pi)^sk(1)*detki)*exp(-0.5*(x-mi)'*invki*(x-mi));
   end
end
%do not consider Drusen
if options.type
   pdfx(:,3)=0;
end;

p=pdfx./(sum(pdfx,2)*ones(1,sk(3)));
[tmp,cl]=max(p,[],2);

if dbf, disp('Finished RETnvfclass'), end
