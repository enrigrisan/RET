function seeds=RETseedpoints(img,ngrid,th,dbf)

if dbf, disp('Inside RETseedpoints'); end;

[nr,nc]=size(img);
qr=round(nr/ngrid);
qc=round(nc/ngrid);

xs=[];
ys=[];
ds=[];
dirs=[];

dbfr=0;

% th=0.7;
% dmin=2;
% vcmin=0.01;
% tf=0;

% estrazione punti sulle colonne
k=qc;
while k<nc,
    scanline=img(1:nr,k)';
    [s,d]=RETseedscan2(scanline,th,dbfr);
    if(~isempty(s))
        x=k*ones(length(s),1);
        y=s';
        xs=[xs;x];
        ys=[ys;y];
        ds=[ds;d'];

        dirs=[dirs;-99*ones(length(s),1)];
    end
    k=k+qc;
end;

dbfc=0;

%estrazione dei punti sulle righe
k=qr;
while k<nr,
    scanline=img(k,1:nc);
    [s,d]=RETseedscan2(scanline,th,dbfc);
    if(~isempty(s))
        x=s';
        y=k*ones(length(s),1);
        xs=[xs;x];
        ys=[ys;y];
        ds=[ds;d'];

        dirs=[dirs;99*ones(length(s),1)];
    end;
    k=k+qr;
end;

try
    if(~isempty(xs))
        seeds=RETseedstransform(xs,ys,ds,dirs,dbf);
    else
        seeds=[];
    end;
catch
    keyboard
end;

if dbf==1,
    Nseed=length(xs)
end;

if dbf, disp('Finished RETseedpoints'); end;
