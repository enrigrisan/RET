
if(~exist('dbf'))
   dbf=1;
end;

if(~exist('cross'))
   testRETcross
end;

if(exist('coeff'))
   scale=coeff;
else,
   scale=1;
end;

if(~exist('ct')),
   ctnum=input('Insert cross number :  ');
end;

%initialization parameters
optionsini.step=5;
optionsini.dimroi=[];
optionsini.searcoeff=2;
optionsini.smooth=0.1;
optionsini.maxd=40;

%Local tracking parameters
optionscross.step=5;
optionscross.mindis=[];
optionscross.mintheta=pi/3;

%Gunn quadrilaterus parameters
optionsgunn.stepth=2*pi/50;
optionsgunn.th=0.30;

segs5=RETgsinitseg(segs3,dbf);
[gunngrade,salusgrade]=RETgunnsalus_single(xroi,segs3,cross,scale,ct,optionsini,optionscross,optionsgunn,dbf)

