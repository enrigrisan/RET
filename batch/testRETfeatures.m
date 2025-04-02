if ~exist('segspline'),
    testRETspline;
end;

%RETlpp parameters
passo=1;

%tortuosity parameters
tortpar.k0=10;
tortpar.h=0.03;
tortpar.passo=0.5;
tortpar.lmin=1;

seglpp=RETlpp(segspline,passo,dbf);

segtort=RETtort(seglpp,tortpar,dbf);