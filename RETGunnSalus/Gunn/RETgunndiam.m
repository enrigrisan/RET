function diam=RETgunndiam(d,ves1,ves2,dbf);

if dbf, disp('Inside RETgunndiam'); end;

x1=ves1.x;
y1=ves1.y;
x2=ves2.x;
y2=ves2.y;

yd1=[max([d(1,1),d(3,1)]),min([d(1,1),d(3,1)])];
xd1=[max([d(1,2),d(3,2)]),min([d(1,2),d(3,2)])];
ct2=2;
ct=1;
ec=0;
while ~ec,
    flag1=and(x1(ct)<=xd1(1),x1(ct)>xd1(2));
    flag2=and(y1(ct)<=yd1(1),y1(ct)>yd1(2));
    ct=ct+1;
    ec=flag1&flag2;
    ec=ec|(ct>length(x1));
end;

for ct=1:4,
    if ct==4,
        ind1=ct;
        ind2=1;
    else
        ind1=ct;
        ind2=ct+1;
    end;
    temp(ct)=sqrt((d(ind1,1)-d(ind2,1))^2+(d(ind1,2)-d(ind2,2))^2);
end;

if flag1&flag2,
    ind1=2;
    ind2=1;
else
    ind1=1;
    ind2=2;
end;

diam(ind2)=0.05*(temp(1)+temp(3));
diam(ind1)=0.05*(temp(2)+temp(4));

if dbf, disp('Finished RETgunndiam'); end;
