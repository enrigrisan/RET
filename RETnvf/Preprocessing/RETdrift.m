%RETDRIFT removes illumination drift.
%   XISO = RETDRIFT(XC,XROI,OPTIONS,DBF) gives on the output the 
%   isoenlighted version of the region of interest XROI extracted from
%   the RGB image XC.
%   M is a vector containing the mean values of the three RGB channel
%   for the output image.
%   SD is the vector containing the standard deviations of the three RGB
%   channel for the output image .
%   WSD is the weight parameter which dets the width of the gray scale range
%   for the free-fundus estimation.
%
%   ADL 2001-06-11.
%   EG  2001-06-11


function [xiso,xmask]=RETdrift(xc,xroi,options,dbf);

if dbf, disp('Inside RETdrift'); end;

% Setting parameters
if(~isempty(options.ord)),
   ord=options.ord;
else
   ord=64;
end;
if(~isempty(options.m)),
   m=options.m;
else
   m=[0.5;0.5;0.5];
end;
if(~isempty(options.sd)),
   sd=options.sd;
else
   sd=[0.03;0.03;0.03];
end;
if(~isempty(options.wsd)),
   wsd=options.wsd;
else
   wsd=1;
end;
if(~isempty(options.thgreen)),
   thgreen=options.thgreen;
else
   thgreen=0.75;
end;

sxc=size(xc);

% Normal fundus mask computation
xc2=xc(:,:,2);
xm2=blkproc(xc2,[ord,ord],'median(x(:))');
xmr2=imresize(xm2,[sxc(1),sxc(2)],'bicubic');
xsd2=blkproc(xc2,[ord,ord],'RETsdev(x)');
xsdr2=imresize(xsd2,[sxc(1),sxc(2)],'bilinear');
% The mask is computed by considering the green values within a 
% range, set by wsd*xsdr2, from the median, and with median smaller
% than thgreen.
% In this way large bright are does not ruins the computation
xmask=(xc2<(xmr2+wsd*xsdr2))&(xc2>(xmr2-wsd*xsdr2))&xroi&(xmr2<thgreen);
indmask=find(~xmask);
%save mask xmask xm2 xmr2 xsd2 xsdr2
%Channel processing

xc2=xc(:,:,2);
xc2m=xc2;
% The median and std of every block of the image are computed considering
% only the normal fundus points, i.e. where xmask is non-zero.
% To achieve this the value of the masked points are set to -1, so that are
% recognized as different from a normal fundus point with zero value.
% Then the possible holes left by the procedure are filled by RETzeromed
% and RETzerosdev
xc2m(indmask)=-1;
xm2=blkproc(xc2m,[ord,ord],'RETmed(x)');
xm2=RETzeromed(xm2,dbf);
xmr2=imresize(xm2,[sxc(1),sxc(2)],'bicubic');
xsd2=blkproc(xc2m,[ord,ord],'RETsdev(x)');
xsd2=RETzerosdev(xsd2,dbf);
xsdr2=imresize(xsd2,[sxc(1),sxc(2)],'bilinear');
xmc2=xc2-xmr2;
xmsdc2=xmc2./xsdr2;
xiso(:,:,2)=xmsdc2*sd(2)+m(2);
xiso(:,:,2)=xiso(:,:,2).*xroi;
if dbf, disp('Finished green channel'); end;
% Clear up a little bit of memory
clear xc2 xc2m xm2 xmr2 xsd2 xsdr2 xmc2 xmsdc2 

xc1=xc(:,:,1);
xc1m=xc1;
% The median and std of every block of the image are computed considering
% only the normal fundus points, i.e. where xmask is non-zero.
% To achieve this the value of the masked points are set to -1, so that are
% recognized as different from a normal fundus point with zero value.
% Then the possible holes left by the procedure are filled by RETzeromed
% and RETzerosdev
xc1m(indmask)=-1;
xm1=blkproc(xc1m,[ord,ord],'RETmed(x)');
xm1=RETzeromed(xm1,dbf);
xmr1=imresize(xm1,[sxc(1),sxc(2)],'bicubic');
xsd1=blkproc(xc1m,[ord,ord],'RETsdev(x)');
xsd1=RETzerosdev(xsd1,dbf);
xsdr1=imresize(xsd1,[sxc(1),sxc(2)],'bilinear');
xmc1=xc1-xmr1;
xmsdc1=xmc1./xsdr1;
xiso(:,:,1)=xmsdc1*sd(1)+m(1);
xiso(:,:,1)=xiso(:,:,1).*xroi;
if dbf, disp('Finished red channel'); end;
% Clear up a little bit of memory
clear xc1 xc1m xm1 xmr1 xsd1 xsdr1 xmc1 xmsdc1

xc3=xc(:,:,3);
xc3m=xc3;
% The median and std of every block of the image are computed considering
% only the normal fundus points, i.e. where xmask is non-zero.
% To achieve this the value of the masked points are set to -1, so that are
% recognized as different from a normal fundus point with zero value.
% Then the possible holes left by the procedure are filled by RETzeromed
% and RETzerosdev
xc3m(indmask)=-1;
xm3=blkproc(xc3m,[ord,ord],'RETmed(x)');
xm3=RETzeromed(xm3,dbf);
xmr3=imresize(xm3,[sxc(1),sxc(2)],'bicubic');
xsd3=blkproc(xc3m,[ord,ord],'RETsdev(x)');
xsd3=RETzerosdev(xsd3,dbf);
xsdr3=imresize(xsd3,[sxc(1),sxc(2)],'bilinear');
xsdr3(find(xsdr3<0.01))=1;
xmc3=xc3-xmr3;
xmsdc3=xmc3./xsdr3;
xiso(:,:,3)=(xmsdc3*sd(3)+m(3));
xiso(:,:,3)=xiso(:,:,3).*xroi;
if dbf, disp('Finished blue channel'); end;
% Clear up a little bit of memory
clear xc3 xc3m xm3 xmr3 xsd3 xsdr3 xmc3 xmsdc3 indmask xroi
xiso(find(xiso>1))=1;
xiso(find(xiso<0))=0;

if dbf, disp('Finished RETdrift'); end;




