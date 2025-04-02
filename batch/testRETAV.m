

if(~exist(xiso) | ~exist(segspline))
    testRETspline
end;

xhsl=rgb2hsv(xiso);

for ct=1:3
    xhsl(:,:,ct)=xhsl(:,:,ct).*xmask;
end;

od(1)=xod;
od(2)=yod;
od(3)=rod;

segnew=IdentifyQuad(segspline,od,dbf);
[vesselno,ref]=GetMajor(segnew);

% Extract vessel chromatic data
[segnew,cr]=PointStat(segnew,vesselno,ref,xiso, xhsl);
xves=VesBin(segnew,vesselno,ref,xiso);

[p2,vesselno2]=VesClassPoint4Quad(segnew,ref,vesselno,[4,5,6]);
ViewClass(segnew, vesselno2,p2,od,xiso);