if ~exist('segtc'),
    testRETfix;
end;

% RETcross parameters

crosspar.destr=30^2;
crosspar.limd=30^2;

crossings=RETcross(segtc,crosspar,dbf);

%RETdispcross(xroi,segtc,crossings,1);