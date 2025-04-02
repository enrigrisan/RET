%debug
if ~exist('dbf')
   dbf=1;
end

if ~exist('xiso')
   testRETpreprocessing
end
if ~exist('xpwhite') | ~exist('xpdark')
   testRETfindpat
end
if ~exist('xbpwhite') | ~exist('xbpdark')
   testRETblob
end

% Features parameters
optionsfeature.wc=0.5;
optionsfeature.type=1;

optionfeature.type=1;
pftwhite=RETnvffeatures(xbpwhite,xiso,xpwhite,optionsfeature,dbf);

optionsfeature.type=0;
pftdark=RETnvffeatures(xbpdark,xiso,xpdark,optionsfeature,dbf);
