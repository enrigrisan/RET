% FRK
% gets set of points from an image
% if a title is specified it is written on top of the figure
% if the the number of  points n is not set (or set to 0), 
% 			points are taken until central or right mouse buttons are pressed

function [r,c]=getpoints(x,n,tit);
h=figure;
simshow(x);
wmax(gcf);
hold on;
if nargin==3, title(tit); end;
ct=0;
ef=0;
while ~ef,
   [xp,yp,button]=ginput(1);
   if nargin>=2, 
      if n,
         ef=~(ct<n); 
      else
         if length(button), 
            ef=button~=1; 
         else
            ef=1;
         end;
      end;
   else
      if length(button), 
         ef=button~=1; 
      else
         ef=1;
      end;
   end;
   if ~ef,
      ct=ct+1;
      r(ct)=fix(yp);
      c(ct)=fix(xp);
      hold on
      plot(c(ct),r(ct),'xr');
      h=text(c(ct)-10,r(ct)-10,num2str(ct));
      set(h,'Color',[0,1,0]);
   end;
end;
close

