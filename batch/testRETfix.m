if ~exist('seg'),
    testRETsparsetrack;
end;

%extrema extraction parameters
%extpar.npd=5;
extpar.npd=3;
%extpar.npb=5;
extpar.npb=3;

%linking parameters
linkpar.dcoeff=1e3;
%linkpar.acoeff=pi/32;
linkpar.acoeff=pi/16;
linkpar.minscore=1e-3;

%splitting parameters
splitpar.minorder=5;
splitpar.mindist=20;

%RETtogli_corti parameters
lungh_min=50;

segfix=RETfix(xroi,seg,extpar,linkpar,splitpar,dbf);

segfix=RETcutsegod(segfix,xod,yod,rod,dbf);

segtc=RETtogli_corti(segfix,lungh_min,dbf);

RETdispseg(xroi,segfix,[0,1,0,1,1]);
RETdispseg(xroi,segtc,[0,1,0,1,1]);