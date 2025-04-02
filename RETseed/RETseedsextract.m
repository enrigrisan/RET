function [x,y,d,dir]=RETseedsextract(seeds,dbf);

if dbf, disp('Inside RETseedsextract'); end;

for ct=1:length(seeds),
    x(ct)=seeds(ct).x;
    y(ct)=seeds(ct).y;
    d(ct)=seeds(ct).d;
    dir(ct)=seeds(ct).dir;
end;

x=x';
y=y';
d=d';
dir=dir';

if dbf, disp('Finished RETseedsextract'); end;
    