
function seg_out=RETgsupdateseg(seg_in,cross,ct,gunngrade,salusgrade,dbf);

if(dbf)
   disp('Inside updateseggs');
end;

seg_out=seg_in;

if(isempty(seg_in(cross(ct).s1).g)),
   seg_out(cross(ct).s1).g=[cross(ct).s2,gunngrade(ct,1)];
   seg_out(cross(ct).s1).s=[cross(ct).s2,salusgrade(ct,1)];
else,
   n=size(seg_in(cross(ct).s1).g,1);
   seg_out(cross(ct).s1).g(n+1,:)=[cross(ct).s2,gunngrade(ct,1)];
   seg_out(cross(ct).s1).s(n+1,:)=[cross(ct).s2,salusgrade(ct,1)];
end;

if(isempty(seg_in(cross(ct).s2).g)),
   seg_out(cross(ct).s2).g=[cross(ct).s1,gunngrade(ct,2)];
   seg_out(cross(ct).s2).s=[cross(ct).s1,salusgrade(ct,2)];
else,
   n=size(seg_in(cross(ct).s2).g,1);
   seg_out(cross(ct).s2).g(n+1,:)=[cross(ct).s1,gunngrade(ct,2)];
   seg_out(cross(ct).s2).s(n+1,:)=[cross(ct).s1,salusgrade(ct,2)];
end;



if(dbf)
   disp('Exit updateseggs');
end;
