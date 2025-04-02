if ~exist('segspline'),
    testRETspline;
end;

%tracking parameters
rettppar.th=0.7;
rettppar.ps=0;
rettppar.diamini=20;
rettppar.dmin=2;
rettppar.vcmin=0.01;
rettppar.w1=1;
rettppar.w2=1;
rettppar.rdc=100;

%filtering parameters
parfilt.fs=31;


%spline approx parameters
smoothxy=0.01;
smoothd=0.01;

dbf=0;

%spline interpolation step
passo=1;
segs1=segspline;
for ct=1:length(segs1)
segs1(ct).ec=-1;
end

segsg=RETsplinegen(segs1,passo,0,dbf);

for ct=1:length(segs1);
    disp(sprintf('Segment %i of %i',ct,length(segs1)));
    [xc,yc,dir,d]=RETtrackpath(xroi,segsg(ct).x,segsg(ct).y,rettppar,dbf);
    segtp(ct).x=xc;
    segtp(ct).y=yc;
    segtp(ct).dir=dir;
    segtp(ct).d=d;
    segtp(ct).ec=[999,999];
end;

segtpf=RETfilter(segtp,parfilt,dbf);

RETdispseg(xroi,segtp,[0,1,0,1,1]);
RETdispseg(xroi,segtpf,[0,1,0,1,1]);


