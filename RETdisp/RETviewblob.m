function hf=RETviewblob(xblob,options,dbf)

if(dbf), disp('Inside RETviewblob');end;

xc=imread([options.path,options.name]);
hf=figure,
imshow(xc)
hold on

maxblob=max(max(xblob));
for ct1=1:maxblob
   [xbi,r,c]=RETminroi(xblob==ct1,dbf);
   contour=xbi-double(erode(xbi,ones(3)));
   [y,x]=find(contour);
   hp=plot(c(1)+x-1,r(1)+y-1,'.');
   if options.fvn
      text(mean(c),mean(r),num2str(ct1))
   end
   if options.type
      %Due to Matlab exporting problems the white color has been set
      %to [1,1,0.99]
      set(hp,'markersize',0.1,'color',[1,1,0.99])
   else
      set(hp,'markersize',0.1,'color',[1,0,0])
   end
end
title(sprintf(options.title));
hold off

if(dbf), disp('Exit RETviewblob');end;
