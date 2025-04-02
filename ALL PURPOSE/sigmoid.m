% FRK - Sigmoid point transform

function y=sigmoid(x,m,n,a,b);
if nargin==1,
   med=0;
   nmf=1;
   amp=0.5;
   bas=0.5;
else
   if nargin<4,
      med=m;
      nmf=n;
      amp=0.5;
      bas=0.5;
   else
      med=m;
      nmf=n;
      amp=a;
      bas=b;
   end;
end;
y=1./(1+exp(-(x-med)/nmf));
y=((y-0.5)/0.5)*amp+bas;
