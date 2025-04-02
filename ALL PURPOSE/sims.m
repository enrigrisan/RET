function h=sims(i,f);
h=figure;
if nargin<2,
   simshow(double(i));
else
   simshow(double(i),f);
end;

pause(0.00001);