function prof=RETimprofile(xroif,x,y,dbf);

if dbf, disp('Inside RETimprofile'); end;

v=[];
prof=[];
dir=[y(2)-y(1),x(2)-x(1)]/(sqrt((x(2)-x(1))^2+(y(2)-y(1))^2));
n=fix(sqrt((x(2)-x(1))^2+(y(2)-y(1))^2));

for ct=1:n,
   v=round(dir*ct+[y(1),x(1)]);
   prof(ct)=xroif(v(1),v(2));
end;

if dbf, disp('Finished RETimprofile'); end;

