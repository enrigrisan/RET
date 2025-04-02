function [ec,xc,yc,ip1,ip2]=RETsegcross(seg,s1,s2,crosspar,dbf);

ss1=length(seg(s1).x);
ss2=length(seg(s2).x);

%determination of points closer than destr
dm=distmatrix([seg(s1).x,seg(s1).y],[seg(s2).x,seg(s2).y]);
[i1,i2]=find(dm<crosspar.destr);

i1=sort(i1);
i2=sort(i2);

si1=length(i1);
si2=length(i2);

crossdata=[];

% cycle running on quadryplets of points closer than destr
i1old=0;
i2old=0;
for ct1=1:si1,
    if (i1(ct1)~=i1old),
        i1old=i1(ct1);
        for ct2=1:si2,
            if (i2(ct2)~=i2old)&(i1(ct1)<(ss1-1))&(i2(ct2)<(ss2-1))&(i1(ct1)>1)&(i2(ct2)>1),
                i2old=i2(ct2);
                p11=[seg(s1).x(i1(ct1)),seg(s1).y(i1(ct1))];
                p12=[seg(s1).x(i1(ct1)+1),seg(s1).y(i1(ct1)+1)];
                p21=[seg(s2).x(i2(ct2)),seg(s2).y(i2(ct2))];
                p22=[seg(s2).x(i2(ct2)+1),seg(s2).y(i2(ct2)+1)];
                    
                if crosscond(p11,p12,p21,p22),
                    crossdata=[crossdata;i1(ct1),i2(ct2)];
%                     plot(p11(1),p11(2),'xg');
%                     plot(p12(1),p12(2),'xg');
%                     plot(p21(1),p21(2),'og');
%                     plot(p22(1),p22(2),'og');
%                     pause;
                end;
            end;
        end;
    end;
end;

% crossing center evaluation
if size(crossdata,1),
    ec=1;
    for ct=1:size(crossdata,1),
        xc(ct)=(seg(s1).x(crossdata(ct,1))+seg(s2).x(crossdata(ct,2))+seg(s1).x(crossdata(ct,1)+1)+seg(s2).x(crossdata(ct,2)+1))/4;
        yc(ct)=(seg(s1).y(crossdata(ct,1))+seg(s2).y(crossdata(ct,2))+seg(s1).y(crossdata(ct,1)+1)+seg(s2).y(crossdata(ct,2)+1))/4;
        ip1(ct)=crossdata(ct,1);
        ip2(ct)=crossdata(ct,2);
    end;
else
    ec=0;
    xc=[];
    yc=[];
    ip1=[];
    ip2=[];
end;

function r=crosscond(p11,p12,p21,p22);

v=p12-p11;
vo(1)=v(2);
vo(2)=-v(1);
r1=(p21-p11)*vo';
r2=(p22-p11)*vo';
c1=((r1*r2)<0)|(r1==0);

v=p22-p21;
vo(1)=v(2);
vo(2)=-v(1);
r1=(p11-p21)*vo';
r2=(p12-p21)*vo';
c2=((r1*r2)<0)|(r1==0);

r=c1&c2;

