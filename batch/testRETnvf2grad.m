%debug
if ~exist('dbf')
   dbf=1;
end

if ~exist('clwhite')|~exist('cldark')|~exist('pwhite')|~exist('pdark')
   testRETnvfclass
end

% View parameters
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

[xblob,nvf]=RETnvf2grad(xbpwhite,xbpdark,clwhite,cldark,pwhite,pdark,dbf);
if dbf
   optionsview.title=['Extra vascular lesions found \n',...
         'Red: Haemorrhages;  Yellow: Exudates;   White: Cotton-wools'];
   RETviewnvf(xblob,nvf,optionsview,dbf); 
end;
