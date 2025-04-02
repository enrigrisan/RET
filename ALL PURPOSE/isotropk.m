function k=isotropk(gg, kk, k, r1,r2);

mk=0;
nk=0;

if k~=0,
	mk=r2*sin(2*pi*kk/k);
	nk=r2*cos(2*pi*kk/k);
end;

origine=r1+1;

for i = 1 : r1*2+1,
	for j = 1 : r1*2+1,
		k(i, j) = exp(-((i-origine-mk)^2+(j-origine-nk)^2)/(gg*gg));
	end;
end; 

