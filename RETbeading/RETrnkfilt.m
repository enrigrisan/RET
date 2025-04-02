% RERrnkfilt
% y=RETrnkfilt(x,w,rnk,dbf)
%
% Rank filter of column vector x, with window w and rank rnk
% 

function y=RETrnkfilt(x,rnk,w,dbf)

if dbf, disp('Inside RETrnkfilt');end;

w2=floor(w/2);
w=2*w2 + 1;

n=length(x);
m=zeros(n+w-1,w);
x0=x(1);
xl=x(n);

for ct=0:(w-1),
   m(:,ct+1)=[x0*ones(ct,1);x;xl*ones(w-ct-1,1)];
end;

for ct1=1:n+w-1,
   y(ct1)=RETprctile(m(ct1,:)',rnk,dbf);
end;

y=y(w2+1:end-w2);
y=y';

if dbf, disp('Finished RETrnkfilt');end;
