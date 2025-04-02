%extrema extraction parameters
extpar.npd=5;
extpar.npb=5;

%splitting parameters
splitpar.minorder=5;
splitpar.mindist=20;

dbf=1;

ext=RETextrema(seg,extpar.npb,extpar.npd,dbf);

segnew=RETsplit(seg,ext,splitpar.minorder,splitpar.mindist,dbf);

%RETdispext(xroi,ext); 
%RETdispseg(xroi,segnew,[0,1,0,1,1]);