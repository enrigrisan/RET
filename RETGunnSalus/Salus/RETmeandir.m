% Compute the mean direction of the barycenters distant between 20 and
% 40 pixels from the estimated crosspoint

function [mdir1,mdir2]=RETmeandir(seg,cross,xc,yc,ct,dbf);

if dbf, disp('Inside RETmeandir'); end;

%FIRST SEGMENT

% d1 distances between the center point and the barycenter of the first
% vessel
%d1=sqrt((cross(ct).x-seg(cross(ct).s1).x).^2+(cross(ct).y-seg(cross(ct).s1).y).^2);
d1=sqrt((xc-seg(cross(ct).s1).x).^2+(yc-seg(cross(ct).s1).y).^2);

%index of the closest barycenter to the crossing
nmin=find(d1==min(d1));

%barycenter distant from 20 to 40 pixels on one side of the crossing
nth=find(and(d1(1:nmin)<=40,d1(1:nmin)>=20));
if(~isempty(nth)),
   %exludes the barycenter which has direction differing for more than
   %pi from the mean direction (tracking inversion)
   ntemp=find(abs(seg(cross(ct).s1).dir(nth)-(mean(mod(seg((cross(ct).s1)).dir(nth),2*pi))))<pi);
else,
   ntemp=[];
end;

if(~isempty(ntemp)),
   %mean direction of the first side
   mdir1(1)=angmed2(seg((cross(ct).s1)).dir(nth(ntemp)),dbf);
else
   mdir1(1)=-1;
end;

%barycenter distant from 20 to 40 pixels on the other side of the crossing
nth=find(and(d1(nmin:length(d1))>=20,d1(nmin:length(d1))<=40));
nth=nth+nmin-1;
if(~isempty(nth)),
   %exludes the barycenter which has direction differing for more than
   %pi from the mean direction (tracking inversion)
   ntemp=find(abs(seg(cross(ct).s1).dir(nth)-(mean(mod(seg((cross(ct).s1)).dir(nth),2*pi))))<pi);
else,
   ntemp=[];
end;

if(~isempty(ntemp)),
   %mean direction of the second side
   mdir1(2)=angmed2(seg((cross(ct).s1)).dir(nth(ntemp)),dbf);
else
   mdir1(2)=-1;
end;

% SECOND SEGMENT
% d2 distances between the center point and the barycenter of the first
% vessel
d2=sqrt((xc-seg(cross(ct).s2).x).^2+(yc-seg(cross(ct).s2).y).^2);

%index of the closest barycenter to the crossing
nmin=find(d2==min(d2));

%barycenter distant from 20 to 40 pixels on one side of the crossing
nth=find(and(d2(1:nmin)<=40,d2(1:nmin)>=20));
if(~isempty(nth)),
   %exludes the barycenter which has direction differing for more than
   %pi from the mean direction (tracking inversion)
   ntemp=find(abs(seg(cross(ct).s2).dir(nth)-(mean(mod(seg((cross(ct).s2)).dir(nth),2*pi))))<pi);
else,
   ntemp=[];
end;

if(~isempty(ntemp)),
   %mean direction of the first side
   mdir2(1)=angmed2(seg((cross(ct).s2)).dir(nth(ntemp)),dbf);
else
   mdir2(1)=-1;
end;

%barycenter distant from 20 to 40 pixels on the other side of the crossing
nth=find(and(d2(nmin:length(d2))>=20,d2(nmin:length(d2))<=40));
nth=nmin-1+nth;
if(~isempty(nth)),
   %exludes the barycenter which has direction differing for more than
   %pi from the mean direction (tracking inversion)
   ntemp=find(abs(seg(cross(ct).s2).dir(nth)-(mean(mod(seg((cross(ct).s2)).dir(nth),2*pi))))<pi);
else,
   ntemp=[];
end;

if(~isempty(ntemp)),
   %mean direction of the second side
   mdir2(2)=angmed2(seg((cross(ct).s2)).dir(nth(ntemp)),dbf);
else
   mdir2(2)=-1;
end;

if dbf, disp('Exit RETmeandir'); end;

