if ~exist('segtc'),
    testRETfix;
end;

if ~exist('coeff'),
    testRETcoeff;
end;

% Waiting for a/v discrimination code....
% segarteries=RETextractarteries(segtc,dbf);
segarteries=segtc;

narr=RETgennarr(segarteries,coeff,dbf);

