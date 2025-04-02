function [seeds,th]=RETthreshold(img,ngrid,vth,nmin,dbf)

if dbf, disp('Inside RETthreshold'); end;

f=0;
i=1;

while f==0 & i<=length(vth);
    th=vth(i);
    seeds=RETseedpoints(img,ngrid,th,dbf);
    if length(seeds)>nmin, 
        f=1;
    end;
    i=i+1;
    if dbf==1,
        disp(sprintf('Threshold tried : %f',th));
    end;
end;


if dbf, disp('Finished RETthreshold'); end;
