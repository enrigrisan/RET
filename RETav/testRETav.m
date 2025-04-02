
%Preprocessing parameters
optionspre.ord=64;
optionspre.m=0.5*ones(3,1);
optionspre.sd=0.03*ones(3,1);
optionspre.wsd=1;
optionspre.thgreen=0.75;

%AV classification options
kerdim=5;
alfa=[0.2,1.5,2];

%extrema extraction parameters
extpar.npd=3;
extpar.npb=3;

%linking parameters
linkpar.dcoeff=1e3;
linkpar.acoeff=pi/16;
linkpar.minscore=1e-3;

%splitting parameters
splitpar.minorder=5;
splitpar.mindist=20;

if(~exist('dbf')),
   dbf=0;
end;

if(~exist('xc')),
   xc=imget;
end;

if ~exist('rod'),
    [r,c]=getpoints(xc(:,:,2),2,'Input optic disk center and radius');
    rod=sqrt((r(1)-r(2))^2+(c(1)-c(2))^2);
    xod=c(1);
    yod=r(1);
end;

if(~exist('xiso')),   
   xiso=RETpreproc(xc,optionspre,dbf);
end;

segcod=RETcutsegod(seg,xod,yod,rod,dbf);
ext=RETextrema(segcod,extpar.npb,extpar.npd,dbf);
segsplit=RETsplit(segcod,ext,splitpar.minorder,splitpar.mindist,dbf);
%segsplitcod=RETcutsegod(segsplit,xod,yod,rod,dbf);

[x,y,c,xyz,lab]=RETchromo(segsplit,xiso,kerdim,dbf);
p=RETchrp(x,y,c,xyz,lab,alfa,dbf);
RETchrdisp(x,y,p,xc,dbf);

%Linking with av information
segav=RETsegav(segsplit,x,y,p,dbf);
ext=RETextrema(segav,extpar.npb,extpar.npd,dbf);
segavsplit=RETsplit(segav,ext,splitpar.minorder,splitpar.mindist,dbf);
ext=RETextrema(segavsplit,extpar.npb,extpar.npd,dbf);
segavsplitlink=RETlink(segavsplit,ext,linkpar.dcoeff,linkpar.acoeff,linkpar.minscore,dbf);

%RETdispav(xc,segav);
%RETdispav(xc,segavsplit);
%RETdispav(xc,segavsplitlink);
