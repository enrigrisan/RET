% FRK
% inputs a vector of file names by means of a GUI

function [pnv,fnv]=batchGUI(spn);
ct=1;
cf=1;
while cf,
   if (nargin<1)&(~exist('spn')),
      [fn,pn]=uigetfile('*.*','Image File Name ...');
      spn=pn;
   else
      [fn,pn]=uigetfile([spn,'*.*'],'Image File Name ...');
   end;
   cf=fn~=0;
   if cf,
      fnv{ct}=fn;
      pnv{ct}=pn;
      disp([sprintf(' %i - ',ct),fnv{ct}]);
      ct=ct+1;
   end;
end;

   
   