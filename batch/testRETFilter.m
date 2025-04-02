if ~exist('segfix'),
    testRETfix;
end;

parfilt.fs=11;

segf=RETfilter(segfix,parfilt,dbf);

RETdispseg(xroi,segfix,[0,1,0,1,1]);
title('Before filtering');
RETdispseg(xroi,segf,[0,1,0,1,1]);
title('After filtering');
