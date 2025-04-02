% FRK - generates a gaussian kernel of size rxr
%		  of amplitude q, sigma aa

function k = gaussk(a, aa, r);

k = zeros(r, r);
origine=fix(r/2)+1;

for i = 1 : r,
	for j = 1 : r
      if i~=origine | j~=origine
         k(i, j) =a * exp( -log( 2*((i-origine)*(i-origine)+(j-origine)*(j-origine)) )/(aa*aa));
      end;
   end;
end;

k(origine,origine) = a;

