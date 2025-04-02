if ~exist('crossings')
   testRETcross;
end;

if ~exist('seglpp')
   testRETfeatures;
end;

%Scale coefficient (size of main vessel coming out oof optic disk)
if ~exist('coeff'),
    testRETcoeff;
end;

%initialization parameters
optionsini.step=5;
optionsini.searcoeff=2;
optionsini.smooth=0.1;
optionsini.maxd=40;

%Local tracking parameters
optionscross.step=5;
optionscross.mintheta=pi/3;

%Gunn quadrilaterus parameters
optionsgunn.stepth=2*pi/50;
optionsgunn.th=0.30;

[gunngrade,salusgrade]=RETgunnsalus(xroi,seglpp,crossings,coeff,optionsini,optionscross,optionsgunn,dbf);
