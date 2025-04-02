if ~exist('segbif'),
    testRETbif;
end;

%Scale coefficient (size of main vessel coming out oof optic disk)
if ~exist('coeff'),
    testRETcoeff;
end;

%RETseg_spline parameters
smoothxy=0.01;
smoothd=0.01;

%RETlpp parameters
passo=.1;

%beading parameters
optionsbead.cutv=5;
optionsbead.rnk=67;
optionsbead.fin=5;
optionsbead.coefth2=0.10;
optionsbead.coefth3=5;
optionsbead.th4=500;
optionsbead.th5=5;
optionsbead.thl=100;
optionsbead.thfan=100;
optionsbead.thdfan=0.1;
optionsbead.minveslength=90;
optionsbead.idamax=4;
optionsbead.coeff=coeff;

%Retcross parameters
crosspar.destr=30^2;
crosspar.limd=30^2;

segbifspl=RETseg_spline(segbif,smoothxy,smoothd,dbf);
segbifspl=RETlpp(segbifspl,passo,dbf);
bifcross=RETcross(segbifspl,crosspar,dbf);
segbead=RETbeading(segbifspl,bifcross,optionsbead,dbf);

%RETdispcross(xroi,segbif,bifcross,1);
%RETviewbead(segbead,xroi);
