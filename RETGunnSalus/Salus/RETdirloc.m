%RETdirloc
% Returns the directions of the two vessels involved in the cross 

function [dirloc1,dirloc2]=RETdirloc(xc,yc,ves1,ves2,dbf);

if dbf,disp('Inside RETdirloc'); end;

t1=RETparam(ves1.x,ves1.y,dbf);
t2=RETparam(ves2.x,ves2.y,dbf);
p1x=polyfit(t1,ves1.x',1);
p1y=polyfit(t1,ves1.y',1);
p2x=polyfit(t2,ves2.x',1);
p2y=polyfit(t2,ves2.y',1);

dirloc1=(mod(angolo([p1x(1),p1y(1)],dbf),2*pi));
dirloc1=RETgscheck2pi(dirloc1,dbf);

dirloc2=(mod(angolo([p2x(1),p2y(1)],dbf),2*pi));
dirloc2=RETgscheck2pi(dirloc2,dbf);

if dbf,disp('Exit RETdirloc'); end;