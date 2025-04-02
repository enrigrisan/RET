% FRK - generates a gaussian kernel of size rxr
%		  of amplitude q, sigma aa

function k = gaussk(a,s,r);

k = zeros(2*r+1,2*r+1);
origine=r+1;

[x,y]=meshgrid([-r:r],[-r:r]');
v=(x.^2+y.^2)/s^2;
k=a*exp(-v);

