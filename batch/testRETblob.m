%Debug
if ~exist('dbf')
   dbf=1;
end

if ~exist('xbwhite') | ~exist('xbdark')
   testRETfindpat
end

% View paramters
if ~exist('optionsview')
   optionsview=struct('name',[],'path',[],'type',[],'fvn',0,'title',[]);
end
if ~isfield(optionsview,'name')
   optionsview.filename=[];
end
if ~isfield(optionsview,'path')
   optionsview.path=[];
end
if isempty(optionsview.name) | isempty(optionsview.path)
   [optionsview.name,optionsview.path]=uigetfile('*.*','Image File Name ...');
   if optionsview.name==0
      clear optionsview
      error('Invalid file name')
   end
end
if ~isfield(optionsview,'type')
   optionsview.type=[];
end
if ~isfield(optionsview,'fvn')
   optionsview.fvn=0;
end
if ~isfield(optionsview,'title')
   optionsview.title=[];
end

%Blob separation parameters
optionsblob.type=1;        
optionsblob.ord=5;
optionsblob.step=0.001;
optionsblob.w=0.2;
optionsblob.maxfcwhite=0.03;
optionsblob.maxfcdark=5;
set.r=1;
set.center=[];
set.dim=[];
optionsblob.se=RETcirck(set,dbf);
optionsblob.tharea=10;


%White lesions blob separation
optionsblob.type=1;
xbwhite=RETsmothblob(xbwhite,optionsblob,dbf);
[xbpwhite]=RETpartblob(xbwhite,xpwhite,optionsblob,dbf);
if dbf
   optionsview.type=1;
   optionsview.title='White lesions after blobs separation';
   RETviewblob(xbpwhite,optionsview,dbf)
end

          
%Dark lesions blob separation
optionsblob.type=0;
xbdark=RETsmothblob(xbdark,optionsblob,dbf);
xbpdark=RETpartblob(xbdark,xpdark,optionsblob,dbf);
if dbf
   optionsview.type=0;
   optionsview.title='Dark lesions after blobs separation';
   RETviewblob(xbpdark,optionsview,dbf)
end
