function segnew=RETsegmergeidp(seg,md,dbf);

if dbf, disp('Inside RETsegmerge'); end;

smd=size(md,1);

v=[];

for ct=1:smd,

    i1=md(ct,1);
    i2=md(ct,2);

    if dbf, 
        disp(sprintf('Linking %i and %i',i1,i2)); 
    end;
    
    v=[v;i2];
    
    for ct2=ct+1:smd,
        if md(ct2,1)==i2, md(ct2,1)=i1; end;
        if md(ct2,2)==i2, md(ct2,2)=i1; end;
    end;
    
    pav1=seg(i1).pav;
    pav2=seg(i2).pav;
    
    p1=[seg(i1).x(1);seg(i1).y(1)];
    p1i=[seg(i1).x(end);seg(i1).y(end)];
    p2=[seg(i2).x(1);seg(i2).y(1)];
    p2i=[seg(i2).x(end);seg(i2).y(end)];
    dv=[dist(p1,p2);dist(p1,p2i);dist(p1i,p2);dist(p1i,p2i)];
    i=find(dv==min(dv));
    i=i(1);
    switch i,
    case 1,
        seg(i1).x=[seg(i2).x(end:-1:1);seg(i1).x(1:end)];
        seg(i1).y=[seg(i2).y(end:-1:1);seg(i1).y(1:end)];
        seg(i1).d=[seg(i2).d(end:-1:1);seg(i1).d(1:end)];
        seg(i1).dir=[seg(i2).dir(end:-1:1)+pi;seg(i1).dir(1:end)];
        seg(i1).ec=[seg(i2).ec(2);seg(i1).ec(2)];
    case 2,
        seg(i1).x=[seg(i2).x(1:end);seg(i1).x(1:end)];
        seg(i1).y=[seg(i2).y(1:end);seg(i1).y(1:end)];
        seg(i1).d=[seg(i2).d(1:end);seg(i1).d(1:end)];
        seg(i1).dir=[seg(i2).dir(1:end);seg(i1).dir(1:end)];
        seg(i1).ec=[seg(i2).ec(1);seg(i1).ec(2)];
    case 3,
        seg(i1).x=[seg(i1).x(1:end);seg(i2).x(1:end)];
        seg(i1).y=[seg(i1).y(1:end);seg(i2).y(1:end)];
        seg(i1).d=[seg(i1).d(1:end);seg(i2).d(1:end)];
        seg(i1).dir=[seg(i1).dir(1:end);seg(i2).dir(1:end)];
        seg(i1).ec=[seg(i1).ec(1);seg(i2).ec(2)];
    case 4,
        seg(i1).x=[seg(i1).x(1:end);seg(i2).x(end:-1:1)];
        seg(i1).y=[seg(i1).y(1:end);seg(i2).y(end:-1:1)];
        seg(i1).d=[seg(i1).d(1:end);seg(i2).d(end:-1:1)];
        seg(i1).dir=[seg(i1).dir(1:end);seg(i2).dir(end:-1:1)+pi];
        seg(i1).ec=[seg(i1).ec(1);seg(i2).ec(1)];
     end;
     
     %d1x=(seg(i1).x(2:length(seg(i1).x))-seg(i1).x(1:length(seg(i1).x)-1)).^2;
     %d1y=(seg(i1).y(2:length(seg(i1).y))-seg(i1).y(1:length(seg(i1).y)-1)).^2;
     %l1=sum(sqrt(d1x+d1y));
     %d2x=(seg(i2).x(2:length(seg(i2).x))-seg(i2).x(1:length(seg(i2).x)-1)).^2;
     %d2y=(seg(i2).y(2:length(seg(i2).y))-seg(i2).y(1:length(seg(i2).y)-1)).^2;
     %l2=sum(sqrt(d2x+d2y));
     l1=length(seg(i1).x);
     l2=length(seg(i2).x);
     seg(i1).pav=1/(l1+l2)*(l1*pav1+l2*pav2);
  end;


%v=mdo(:,2);
v=sort(v);

for ct=1:smd,
    seg(v(ct))=[];
    v=v-1;
end;

segnew=seg;

if dbf, disp('Finished RETsegmerge'); end;

function d=dist(p1,p2);
d=sum((p1-p2).^2);