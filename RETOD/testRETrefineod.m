clear
close all
[fn,pn]=uigetfile('*.*','Image File Name ...');
cfn=[pn,fn];
imgin=double(imread(cfn));

figure(1);imshow(imgin/255);hold on;
[xci,yci]=ginput(1);
plot(xci,yci,'o');
roimask=ones(size(imgin,1),size(imgin,2));

K=100;
rdisk=110;
step=10;
templ=zeros(2*rdisk+1);
templ=paintcircle(templ,rdisk,rdisk,rdisk,1);
% figure;imshow(templ);
 [imgcorr,xmax,ymax,corrmax]= RETODmatchcirc(imgin,templ,roimask,step,int32(xci)-K,int32(yci)-K,2*K,2*K);
%[imgcorr,xmax,ymax,corrmax]= RETODmatchcirc2(x,rdisk,roimask,10,int32(xci)-K,int32(yci)-K,2*K,2*K);

imgin=paintcircle(imgin,xmax,ymax,rdisk,1);
figure;imshow(imgin/255);hold on;
plot(xmax,ymax,'x');
