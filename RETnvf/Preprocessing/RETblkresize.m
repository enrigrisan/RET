function [xr,r,c]=RETblkresize(x,ord,dbf)

%RETblkresize redimensions input image.
%   [XR,R,C] = RETblkresize(X,ORD,DBF) redimanesion input image X 
%   so that its dimensions are integer multiples of ORD and the 
%   image is the bigger image contained in the input one.
%
%   ADL 2001-04-14
%   EG  2001-04-27

if dbf, disp('Inside RETblkresize'); end

sx=size(x);
   
r=[1,fix(sx(1)/ord)*ord];
c=[1,fix(sx(2)/ord)*ord];
   
xr=x(r(1):r(2),c(1):c(2),:);

if dbf, disp('Finished RETblkresize'); end
