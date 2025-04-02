function y=RETODcorr2(roi,roimask,x,y,r);
roi=roi(:,:,1);
roi=roi.*roimask;
circmask=zeros(size(roi));
circmask=paintcircle(circmask,x,y,r,1);
% roitmp=roi.*circmask;
y=mean(roi(find(circmask)));