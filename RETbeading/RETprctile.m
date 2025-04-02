
function y=RETprctile(x,p,dbf);

if dbf, disp('Inside RETprctile'); end;

sx=length(x);
xx=sort(x);
q=[0,100*(0.5:sx-0.5)./sx,100];
xx=[min(x);xx;max(x)];

n=find(q==p);
if(~isempty(n)),
   y=xx(n);
else,
   n=find(q<=p);
   n=n(length(n));
   %Linear interpolation between the values
   a=(xx(n)-xx(n+1))/(q(n)-q(n+1));
   b=xx(n)-a*q(n);
   y=a*p+b;
end;

if dbf, disp('Finished RETprctile'); end;