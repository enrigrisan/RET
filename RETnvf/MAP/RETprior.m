% RETprior
% Computes the a-priori probability images for white lesions, dark lesions,
% and normal fundus, based on the OD coordinates and vessels tree.

function xpp=RETprior(x,xroi,seg,xod,yod,rod,options,dbf)

if dbf, disp('Inside RETprior'), end

sx=size(x);
xpvessel=RETpriorvsl(seg,x,options,dbf);
sets.r=rod;
sets.center=[yod,xod];
sets.dim=sx;
xpod=RETcirck(sets,dbf).*(1-xpvessel);

xpwhite=options.pwhite*(ones(sx).*(1-xpod).*(1-xpvessel));
xpdark=options.pdark*(ones(sx).*(1-xpod).*(1-xpvessel));
xpnormal=options.pnormal*(ones(sx).*(1-xpod).*(1-xpvessel))+xpod+xpvessel;

xpp(:,:,1)=xpdark.*xroi;
xpp(:,:,2)=xpnormal.*xroi;
xpp(:,:,3)=xpwhite.*xroi;

if dbf, disp('Finished RETprior'), end