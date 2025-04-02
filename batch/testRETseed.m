dbf=1;

if ~exist('xo');
    [fn,pn]=uigetfile('*.*','Image File Name ...');
    cfn=[pn,fn];
    xiso=im2double(imread(cfn));
    xo=xiso(:,:,2);
end;

%     entire=input('Entire image (1/0) ?');
%     if ~length(entire)|~entire,
%         xroi=nmlz2(getroi(xo));
%     else
%         xroi=nmlz2(xo);
%     end;

xroi=nmlz2(xo);
if ~exist('rod'),
    imagesc(xroi);
    [r,c]=ginput(2);
     %[r,c]=getpoints(xroi,2,'Input optic disk center and radius');
     rod=sqrt((r(1)-r(2))^2+(c(1)-c(2))^2);
     xod=r(1);
     yod=c(1);
     
     [imx,imy]=meshgrid(1:size(xroi,2),1:size(xroi,1));
     imdist=sqrt((imx-xod).^2+(imy-yod).^2);
     xmask=(imdist>2*rod);%.*(imdist<5*rod);
     xroi=xroi.*xmask;
end;

%rod=1;
%xod=1;
%yod=1;

ngridspace=input('ngrid >>');
ngrid=fix(min(size(xroi,1)/ngridspace,size(xroi,2)/ngridspace));
nmindens=input('nmin density (pixels) >>>');
nmin=2*ngrid*nmindens;

vth=[0.03 0.025 0.02 0.015 0.014 0.013 0.012 0.011 0.01];
glfilt=[0.1, 0.3, 0.6, 1, 0.6, 0.3, 0.1];
dlims=[2,50];
nsd1=2;
nsd2=2.5;
dmin=fix(min(size(xroi)/ngrid));
disp(sprintf('Using RETcutseed1 with distance set to : %f',dmin));

seeds=RETseed(xroi,ngrid,vth,nmin,dmin,glfilt,dlims,nsd1,nsd2,xod,yod,rod,dbf);

% 
%title('After masking');
