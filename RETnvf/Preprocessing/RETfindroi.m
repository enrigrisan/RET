function xroi=RETfindroi(x,dbf)

%RETfindroi computes a mask for the input image excluding the black borders.
%
%   ADL 2001-04-18.
%   EG  2001-04-27

if dbf, disp('Inside RETfindroi'); end
sx=size(x);

tharea=30000;
sets.r=[];
sets.dim=[];
sets.center=[];

xangle=x(end-50:end,end-50:end);
xroi=double(x>max(max(xangle)));
% Often disconnected components appear in the mask.
% By convolving with a kernel of ones and subsequently
% thresholding, the holes are filled
sets.r=2;
xroi=imerode(xroi,RETcirck(sets,dbf));
xroi=conv2(xroi,ones(5),'same')>0;
% The borders of the mask are cut by the erosion
sets.r=20;
%sets.r=fix(sqrt(sx(1)*sx(2)/(pi*1544)));
xroi=imerode(xroi,RETcirck(sets,dbf));
% If different connected components are present, they have to be large enough
% to be considered in the mask, otherwise are considered background
label=bwlabel(xroi);
for ct1=1:max(max(label))
   ind=find(label==ct1);
   if length(ind)<tharea
      xroi(ind)=0;
   end
end
xroi=double(xroi);

if dbf, disp('Finished RETfindroi'); end