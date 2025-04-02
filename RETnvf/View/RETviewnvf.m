% RETviewnvf
% Display the classified lesions, the lesions being described by the blob
% image xblob and nvf array of structures coming from RETnvf2grad

function hf=RETviewnvf(xblob,nvf,options,dbf)

if dbf, disp('Inside RETviewnvf'), end

se=[0,1,0;
    1,1,1;
    0,1,0];
xc=imread([options.path,options.name]);
hf=figure;imshow(xc),
hold on
for ct1=1:max(max(xblob));
   switch nvf(ct1).type
   case {'haemorrhage'}, 
      %[xb,rifr,rifc]=RETminroi(xblob==ct1,dbf);
      %contour=xb-double(erode(xb,se));
      %[y,x]=find(contour);
      %y=y+rifr(1)-1;
      %x=x+rifc(1)-1;
      %hp=plot(x,y,'.');
      %set(hp,'markersize',0.1,'color',[1,0,0]);
   case {'exudate'}, 
      [xb,rifr,rifc]=RETminroi(xblob==ct1,dbf);
      contour=xb-double(erode(xb,se));
      [y,x]=find(contour);
      y=y+rifr(1)-1;
      x=x+rifc(1)-1;
      hp=plot(x,y,'.');
      set(hp,'markersize',0.1,'color',[1,1,0]); 
   case {'cws'}, 
      %[xb,rifr,rifc]=RETminroi(xblob==ct1,dbf);
      %contour=xb-double(erode(xb,se));
      %[y,x]=find(contour);
      %y=y+rifr(1)-1;
      %x=x+rifc(1)-1;
      %hp=plot(x,y,'.');
      %set(hp,'markersize',0.1,'color',[1,1,0.99]);
   end
   if options.fvn
      text(mean(x),mean(y),num2str(ct1))
   end 
end
title(sprintf(options.title))
hold off

if dbf, disp('Finished RETviewnvf'), end
