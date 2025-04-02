function cross=RETcross(seg,crosspar,dbf)
if dbf, disp('Inside RETcross'); end;

cross=[];

sseg=length(seg);
for ct1=1:sseg,
    for ct2=ct1+1:sseg,
        %disp([num2str(ct1),'-',num2str(ct2)]);
        if RETpossoverlap(seg,ct1,ct2,dbf),
            ec=0;
            xc=[];
            yc=[];
            [ec,xc,yc,i1,i2]=RETsegcross(seg,ct1,ct2,crosspar,dbf);
            if ec
                sxc=length(xc);
                for ct3=1:sxc,
                    if ~presencecheck(xc(ct3),yc(ct3),cross,crosspar.limd),
                        ncross.x=xc(ct3);
                        ncross.y=yc(ct3);
                        ncross.s1=ct1;
                        ncross.s2=ct2;
                        ncross.i1=i1(ct3);
                        ncross.i2=i2(ct3);
                        cross=[cross;ncross];
                    end;
                end;
            end;
        end;
    end;
end;
if dbf, disp('Finished RETcross'); end;


function ec=presencecheck(xc,yc,cross,limd)
ct=1;
ec=0;
while (ct<=length(cross))&~ec,
    d=(xc-cross(ct).x)^2+(yc-cross(ct).y)^2;
    ec=d<=limd;
    ct=ct+1;
end;

