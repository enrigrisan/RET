%SIGMOID PARAMETERS

if ~exist('segbead'),
    testRETbead;
end;

if ~exist('segtort'),
    testRETfeatures;
end;

if ~exist('gunngrade'),
    testRETgunnsalus;
end;

if ~exist('narr'),
    narr=RETgennarr(segtort,coeff,dbf);
end;

if ~exist('nvf'),
     testRETnvf;
end;



%Beading Normalization
bgen=[100,0.12,0,1];

%Vascular Features
%parv.tortuosity=[3,1.5,-0.011,1.011];
parv.tortuosity=[1.5,1.8,-0.0671,1.0671];
parv.gennar=[-30,.45,0,1,0.2];
parv.bead=[5,0,-1,2];
parv.gunn=[10,0.14,-0.2466,1.2467];
parv.salus=[8,0.8,-0.1085,1.1085];
weightv=[1.2,0.8,0.8,1,1];

%Non Vascular Features
weightnv=[1,1,1];
%parnv.reliability=[1,13,0,1];
parnv.reliability=[4,4.8,0,1];
%parnv.level=[.05,100,0.75,0.25];
%parnv.level=[.15,33,0.75,0.25];
parnv.level=[.04,80,0.75,0.25];

%Index parameter
gamma=0.75;

%Salus threhsold 
thsalus=pi/6;

indexes=RETextractind(segbead,segtort,gunngrade,salusgrade,narr,coeff,thsalus,bgen,dbf);

[iv,vindex]=RETvindex(indexes,weightv,parv,dbf);

[inv,acchaem,accexud,acccws]=RETnvfindex(nvf,coeff,weightnv,parnv,dbf);

index=RETindex(iv,inv,gamma,dbf);

