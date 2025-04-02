%RETestraiinit
% Given the cross structure, it extracts the initial and final points from which
% perform the fine tracking of the two segments involved in the crossing
% It extracts returns the direction of the two couples of points, and the 
% mean diameter of the vessels

function [x1,y1,x2,y2,direzioni1,direzioni2,dim1,dim2]=RETgsestraiinit(seg,cross,dbf);

if dbf, disp('Inside estraiinit'); end;

%first segment
if dbf, disp('First segment'); end;

n=[];
dim1=mean(seg(cross.s1).d);
dth=max(10,dim1);
d1=sqrt((cross.x-seg(cross.s1).x).^2+(cross.y-seg(cross.s1).y).^2);
nth=find(d1(1:cross.i1)>=dth);
if(~isempty(nth))
   n(1)=nth(length(nth));
   nth=find(d1(cross.i1+1:length(d1))>=dth);
   if(isempty(nth)),
      n(2)=find(d1(cross.i1+1:length(d1))>=max(d1(cross.i1+1:length(d1))))+cross.i1;
   else,
      n(2)=nth(1)+cross.i1+1;
   end;
   y1=[seg(cross.s1).y(n(1)),seg(cross.s1).y(n(2))];
   x1=[seg(cross.s1).x(n(1)),seg(cross.s1).x(n(2))];
   mod1=sqrt((x1(1)-x1(2))^2+(y1(1)-y1(2))^2);
   direzioni1(1,:)=[x1(2)-x1(1),y1(2)-y1(1)]/mod1;
   direzioni1(2,:)=-direzioni1(1,:);
else,
   x1=[];
   y1=[];
   direzioni1=[];
   dim1=[];
end;


%second segment
if(dbf), disp('Second segment'); end;

n=[];
dim2=mean(seg(cross.s2).d);
dth=max(10,dim2);
d2=sqrt((cross.x-seg(cross.s2).x).^2+(cross.y-seg(cross.s2).y).^2);
nth=find(d2(1:cross.i2)>=dth);
if(~isempty(nth))
   n(1)=nth(length(nth));
   nth=find(d2(cross.i2+1:length(d2))>=dth);
   if(isempty(nth)),
      n(2)=find(d2(cross.i2+1:length(d2))>=max(d2(cross.i2+1:length(d2))))+cross.i2;
   else,
      n(2)=nth(1)+cross.i2;
   end;
   x2=[seg(cross.s2).x(n(1)),seg(cross.s2).x(n(2))];
   y2=[seg(cross.s2).y(n(1)),seg(cross.s2).y(n(2))];
   mod2=sqrt((x2(1)-x2(2))^2+(y2(1)-y2(2))^2);
   direzioni2(1,:)=[x2(2)-x2(1),y2(2)-y2(1)]/mod2;
   direzioni2(2,:)=-direzioni2(1,:);
else
   x2=[];
   y2=[];
   direzioni2=[];
   dim2=[];
end;

if dbf, disp('Exit estraiinit'); end;