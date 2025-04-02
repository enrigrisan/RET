function [x,y]=RETgsorimcoord(xc,yc,dimroi,xcross,ycross,dbf);

if dbf, disp('Inside orimcoord'); end;

x=((xc-1)/10)+xcross-dimroi-1;
y=((yc-1)/10)+ycross-dimroi-1;

if dbf, disp('Finished orimcoord'); end;
