function ec=RETpossoverlap(seg,i1,i2,dbf);

if dbf, disp('Inside RETpossoverlap'); end;

s1=length(seg(i1).x);
s2=length(seg(i2).x);

c=max(seg(i1).x)<min(seg(i2).x);
c=c|(min(seg(i1).x)>max(seg(i2).x));
c=c|(max(seg(i1).y)<min(seg(i2).y));
c=c|(min(seg(i1).y)>max(seg(i2).y));

ec=~c;

% c1=(seg(i1).x(1)>seg(i2).x(1));
% c1=c1&(seg(i1).x(1)>seg(i2).x(s2));
% c1=c1&(seg(i1).x(s1)>seg(i2).x(1));
% c1=c1&(seg(i1).x(s1)>seg(i2).x(s2));
% 
% c2=(seg(i1).y(1)>seg(i2).y(1));
% c2=c2&(seg(i1).y(1)>seg(i2).y(s2));
% c2=c2&(seg(i1).y(s1)>seg(i2).y(1));
% c2=c2&(seg(i1).y(s1)>seg(i2).y(s2));

%ec=~(c1&c2);

if dbf, disp('Finished RETpossoverlap'); end;
