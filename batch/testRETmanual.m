if(~exist('xroi'))
    xroi=loadimage;
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
ct=1;

while ct>0,
    
    [sx,sy,r,c]=RETInteractiveSamples(xroi,dbf);
    disp(sprintf('Segment %i',ct));
    disp(sprintf('Samples sx=%i   sy=%i',length(sx),length(sy)));
    [xc,yc,dir,d]=RETtrackpath(xroi,sx,sy,rettppar,dbf);
    segman(ct).x=xc;
    segman(ct).y=yc;
    segman(ct).dir=dir;
    segman(ct).d=d;
    segman(ct).ec=[999,999];
    cont=input('Track another segment? Y/N','s');
    if(cont=='Y' || cont=='y')
        ct=ct+1;
    else
        ct=0;
    end;
end;


segmansp=RETseg_spline(segman,smoothxy,smoothd,dbf);

RETdispseg(xroi,segman,[0,1,0,1,1]);
RETdispspline(xroi,segmansp,[1,1,1]);