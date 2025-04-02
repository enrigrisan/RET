%Debug
if ~exist('dbf')
   dbf=1;
end

if ~exist('xiso') | ~exist('xroi')
   testRETpreprocessing
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

% Priors parameters
optionsprior.pdark=0.1;
optionsprior.pnormal=0.8;
optionsprior.pwhite=0.1;
optionsprior.step=1;
optionsprior.w=1.5;

% MAP density functions
pdf.m(:,:,1)=[0.4150304,   0.49083119649032,   0.59367352412167;
   0.351887,   0.48784380571012,   0.62950920109541;
   0.4660174,   0.49866710853519,   0.61424822658389];

pdf.m(:,:,2)=[0.4150304,   0.49083119649032,   0.56608045582453;
   0.351887,   0.48784380571012,   0.58483098760990;
   0.4660174,   0.49866710853519,   0.53587534070950];

pdf.sd(:,:,1)=[0.1334442,   0.02938722822846,   0.06509436735522;
   0.0959899,   0.03976567037163,   0.07597960841415;
   0.1028416,   0.03129444678705,   0.07094277274384];

pdf.sd(:,:,2)=[0.1334442,   0.02938722822846,   0.05878816971307;
   0.0959899,   0.03976567037163,   0.06497147177050;
   0.1028416,   0.03129444678705,   0.03382341355950];

pdf.a=[0.4,0.33,0.39];
pdf.n=[.0378,.00004124,.00039714];

% Prior image
if ~(exist('xod') & exist('yod') & exist('rod'))
    [odrow,odcol]=getpoints(xiso(:,:,1),2,'Optic disk');
    xod=odcol(1);
    yod=odrow(1);
    rod=sqrt(diff(odrow)^2+diff(odcol)^2);
end
xpp=RETprior(xiso(:,:,1),xroi,segs3,xod,yod,rod,optionsprior,dbf);

% Blob lesions determination
[xcl,xpcl]=RETfindpat(xiso,xpp,pdf,dbf);
if dbf
   sims(xcl.*xroi)
   title('Classificazione puntale, in nero patologie scure, in bianco patologie chiare')   
end

xbwhite=double(xcl==3).*xroi;
xpwhite=xpcl(:,:,3).*xroi;
xbdark=double(xcl==1).*xroi;
xpdark=xpcl(:,:,1).*xroi;
