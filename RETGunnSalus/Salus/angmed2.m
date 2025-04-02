function med=angmed2(angles,dbf)


if dbf, disp('Inside angmed2'); end;

med=atan2(sum(sin(angles)),sum(cos(angles)));

if dbf, disp('Finished angmed2'); end;

