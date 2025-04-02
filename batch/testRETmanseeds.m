if ~exist('xo');
    xo=loadgsimage;
    entire=input('Entire image (1/0) ?');
    if ~length(entire)|~entire,
        xroi=nmlz2(getroi(xo));
    else
        xroi=nmlz2(xo);
    end;
end;

if ~exist('rod'),
    [r,c]=getpoints(xroi,2,'Input optic disk center and radius');
    rod=sqrt((r(1)-r(2))^2+(c(1)-c(2))^2);
    xod=c(1);
    yod=r(1);
end;

np=input('Input number of seed points >> ');
[r,c]=getpoints(xroi,np);
seeds=[];
for ct=1:length(r),
    seeds(ct).x=c(ct);
    seeds(ct).y=r(ct);
    seeds(ct).d=10;
    seeds(ct).dir=99;
end;
