%debug
if ~exist('dbf')
   dbf=1;
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

% Preprocessing parameters
optionspre.ord=100;
optionspre.m=0.5*ones(3,1);
optionspre.sd=0.03*ones(3,1);
optionspre.wsd=1;
optionspre.thgreen=0.75;

% Image loading
xc=im2double(imread([optionsview.path,optionsview.name]));

[xiso,xroi,xmask]=RETpreproc(xc,optionspre,dbf);
if dbf
   figure,imshow(xiso)
   title('Isoenlighted image')
end
