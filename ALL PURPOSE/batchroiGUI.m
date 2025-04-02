% FRK
% inputs a vector of file names and corresponding ROI by means of a GUI

function [pnv,fnv,rv,cv]=batchroiGUI(spn);
ct=1;
cf=1;
fn='';
pn='';
while cf,
   if (nargin<1)&(~exist('spn')),
      [nfn,npn]=uigetfile('*.*','Image File Name ...');
      spn=npn;
   else
      [nfn,npn]=uigetfile([spn,'*.*'],'Image File Name ...');
   end;
   cf=nfn~=0;
   if cf,
      
      %if length(nfn)~=length(fn)|length(npn)~=length(pn)|(nfn~=fn)|(npn~=pn),
      %   pn=npn;
      %   fn=nfn;
      %   cfn=[pn,fn];
      %   xo=double(imread(cfn));
      %end;
      pn=npn;
      fn=nfn;
      cfn=[pn,fn];
      xo=double(imread(cfn));
      
      if size(xo,3)>1, 
         x1=nmlz(xo(:,:,1)); 
      end;
      [xroi,rroi,croi]=getroi(x1,['Input ROI for image ',fn]);
      rv{ct}=fix(rroi);
      cv{ct}=fix(croi);
      fnv{ct}=fn;
      pnv{ct}=pn;
      disp([sprintf(' %i - ',ct),fnv{ct},sprintf('( %i,%i -> %i,%i )',croi(1),rroi(1),croi(2),rroi(2))]);
      ct=ct+1;
   end;
end;
