function r = RETcorr2(xa,xb,dbf)
%CORR2 Compute 2-D correlation coefficient.
%   R = CORR2(xa,xb) computes the correlation coefficient between xa
%   and xb, where xa and xb are matrices  of the same size.
%
%   Class Support
%   -------------
%   xa and xb can be of class double or of any integer class.  R
%   is xa scalar of class double.
%
%   ADL 24-05-2001

if dbf, disp('Inside RETcorr2'); end;
xa = xa - mean2(xa);
xb = xb - mean2(xb);

if any(any(xa)) & any(any(xb))
   r = sum(sum(xa.*xb))/sqrt(sum(sum(xa.*xa))*sum(sum(xb.*xb)));
else 
   if xor(any(any(xa)),any(any(xb)))
      r=0;
   else
      r=1;
   end
end
if dbf, disp('Finished RETcorr2'); end;



