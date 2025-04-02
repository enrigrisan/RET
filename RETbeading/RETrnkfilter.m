
%	--------------------------
%	- Funzione RETrnkfilter -
%	--------------------------
%
%   Return the filtered version of the unidimensional input signal, with 
%   with an N rank filter    
%
%   For N odd, Out(k) is the rnkentile of In( k-(N-1)/2 : k+(N-1)/2 ).
%   For N even   , Out(k) is the rnkentile of In( k-N/2 : k+N/2-1 ).
%
%   Default:
%   N = 3, rnk = 50.
%
% Sintax:
%
%	Out = RETrnkfilter(In, rnk, N, flag Debug)
%

function y=RETrnkfilter(x,rnk,n,dbf)

if dbf, disp(' Inside RETrnkfilter'); end;

nx=length(x);

m=fix(n/2);
x=[zeros(m,1);x;zeros(m,1)];
if 2*m<n,
    x=[x;0];
end;

y=zeros(1,nx);

for i=1:nx,
    xx=x(i:i+n);
    y(i)=prctile1(xx,rnk);
    dist=abs(y(i)-xx);
    md=min(dist);
    imd=find(dist==md);
    imd=imd(1);
    y(i)=xx(imd);
end
y=y';

if dbf, disp(' Finished RETrnkfilter'); end;
