if ~exist('segtc'),
    testRETfix;
end;

if ~exist('dbf'),
   dbf=0;
end;

%RETseg_spline parameters
smoothxy=0.01;
smoothd=0.01;

segspline=RETseg_spline(segtc,smoothxy,smoothd,dbf);

%RETdispspline(xroi,segspline,[1,1,1]);
%title('After first spline approximation');



