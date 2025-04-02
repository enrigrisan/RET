if ~exist('segtc'),
    testRETfix;
end;

%extrema extraction parameters
extpar.npd=5;
extpar.npb=5;

%splitting parameters
splitpar.minorder=5;
splitpar.mindist=20;

%bif parameters
bifpar.mindist=(40^2)*3;

dbf=0;

[segbif,bif]=RETbif(segfix,extpar,splitpar,bifpar,dbf);

segord=RETorder(segbif,bif,xod,yod,dbf);

%RETdispbif(xroi,segord,bif,[0,1,0,1,1]);
%RETdispseg(xroi,segord,[0,1,0,1,1],100);
