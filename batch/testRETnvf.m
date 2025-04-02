%debug
if ~exist('dbf')
   dbf=1;
end

%Load Image
[optionsview.name,optionsview.path]=uigetfile('*.*','Image File Name ...');
if optionsview.name==0
   clear optionsview
   error('Invalid file name')
end
optionsview.type=[];
optionsview.fvn=0;
optionsview.title=[];

if ~exist('segs3')
	segs3=[];
end;

if (~exist('xroi')|~exist('xiso')),
   disp('testRETpreprocessing')
   testRETpreprocessing;
end;

if (~exist('xbwhite')|~exist('xbdark')|~exist('xpwhite')|~exist('xpdark')),
   disp('testRETfindpat')
   testRETfindpat;
end;

if (~exist('xbpwhite')|~exist('xbpdark')),
   disp('testRETblob')
   testRETblob;
end;

if (~exist('pftwhite')|~exist('pftdark')),
   disp('testRETnvffeatures')
   testRETnvffeatures;
end;

if (~exist('clwhite')|~exist('cldark')|~exist('pwhite')|~exist('pdark')),
   disp('testRETnvfclass')
   testRETnvfclass;
end;

testRETnvf2grad




  


