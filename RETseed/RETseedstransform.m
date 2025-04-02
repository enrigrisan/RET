function seeds=RETseedstransform(x,y,d,dir,dbf);

if dbf, disp('Inside RETseedstransform'), end;

for ct=1:length(x);
    seeds(ct).x=x(ct);
    seeds(ct).y=y(ct);
    seeds(ct).d=d(ct);
    seeds(ct).dir=dir(ct);
end;
    
if dbf, disp('Finished RETseedstransform'), end;