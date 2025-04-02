if ~exist('xo');
    xo=loadgsimage;
    xroi=getroi(xo);
end;

ngrid=input('ngrid >>');
nmin=input('nmin >>');

vth=[0.03 0.025 0.02 0.015 0.014 0.013 0.012 0.011 0.01];

dmin=20;
glfilt=[0.1, 0.3, 0.6, 1, 0.6, 0.3, 0.1];
dlims=[2,20];

if(~exis('dbf')),
   dbf=1;
end;

% ricerca della soglia ed estrazione seed-points
[xs1,ys1,ds1,th]=RETthreshold(xroi,ngrid,vettsoglie,nmin,dbf);

%primo diradamento dei seed-point(sulla distanza e media grigi)
[xs2,ys2,ds2]=RETcutseed1(xs1,ys1,ds1,dmin,xroi,glfilt,dbf);

%secondo diradamento (sulla larghezza della derivata)
[xs3,ys3,ds3]=RETcutseed2(xs2,ys2,ds2,dlims,dbf);

sims(xroi);
hold on;
plot(xs1,ys1,'x');

sims(xroi);
hold on;
plot(xs2,ys2,'x');

sims(xroi);
hold on;
plot(xs3,ys3,'x');