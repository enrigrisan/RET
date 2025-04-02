function y=RETfishertrasf(x,options,dbf),

%RETFISHERTRASF Linear Fisher transform, so to mimize the features vector dimension 
%   mantaining the same separability coefficient (j3-optimality)
%   The column of the transfomation matrix T are the eigenvestors of the matrix 
%                          F=((Sw)^-1)*Sb 
%   where Sw is the within scatter matrix and Sb is the between scatter matrix 
%   obtained by a proper training set.
%   F has rank M-1, where M is the number of classes in which the original  
%   space is subdivided
%   With M=3, the transformed features vector given by  y=T'*x has dimension two g
%   Fisher ratio is:
%
%                           j3=trace(F)
%
%   and J3(y)=J3(x).
%   X is a input row vwctor. If X is a matrix, every column is a feature and  
%   every row a realization
%   OPTIONS: stucture with fields [TYPE,TWHITE,TDARK] 
%   TYPE: flag of white or dark pathologic sign
%   TWHITE and TDARK are the transform matrices for the two patholgical sign white
%   and dark
%   
%   DBF: debug flag.
%
%   ADL 2001-05-15
%   EG  2001-05-21


if dbf, disp('Inside RETfishertrasf'), end

if options.type
   t=options.twhite;
else
   t=options.tdark; 
end

y=x*t;
 
if dbf, disp('Finished RETfishertrasf'), end
    