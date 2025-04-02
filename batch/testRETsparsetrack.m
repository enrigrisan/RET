if ~exist('seeds'),
    testRETseed;
end;

%retdiam parameters
rdpar.nb=3;
rdpar.th=0.9;
rdpar.dmin=2;
rdpar.vcmin=0.01;
rdpar.tf=0;

%tracking parameters
%trackpar.stini=10;
trackpar.stini=5;
%trackpar.stini=1;
trackpar.th=0.7;
trackpar.dmin=2;
%trackpar.dmin=5;
trackpar.vcmin=0.01;
trackpar.rdc=2;

%bubble continue parameters
bubpar.nb=20;
bubpar.ri=trackpar.stini;
bubpar.bst=1;
bubpar.th=0.7;
bubpar.del=[3,40];
bubpar.split=0;
bubpar.cfth=0;
bubpar.cmne=bubpar.nb/2;
bubpar.mincdist=bubpar.bst*bubpar.nb/5;
bubpar.mindistn=bubpar.nb/10;

%sparse tracking parameters
stpar.lsegmin=40/trackpar.stini;
stpar.doverlap=trackpar.stini;
stpar.noverlap=5;
stpar.dseed=10;
stpar.dseedr=10;

tic;
%seg=RETsparsetrack2(xroi,xs,ys,ds,nb,trackpar,lsegmin,rcont,doverlap,noverlap,dseed,dseedr,dbf);
seg=RETsparsetrack3(xroi,seeds,rdpar,trackpar,bubpar,stpar,dbf);
tfinal=toc;

disp(sprintf('PROCESSING TIME: %f',tfinal));

RETdispseg(xroi,seg,[0,1,0,1,1]);