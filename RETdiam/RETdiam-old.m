function [ds,xc,yc,xl,yl,ec]=RETdiam2(x,xcen,ycen,dbf);
if dbf, disp('>>> Inside RETdiam2'); end;

th=0.7;
dmin=2;
%vcmin=0.1;
vcmin=0.3;
tf=0;

ds=[];
xc=[];
yc=[];
xl=[];
yl=[];
ec=[];

rmin=10;
rmax=20;

av=[];
medlv=[];

for r=rmin:rmax;
   ps=fix(r*2*pi/8)*2;
   [xc,yc,lv,v]=RETscan(x,th,xcen,ycen,r,ps,0,2*pi,dmin,vcmin,tf,dbf);
   if length(xc),
      mlv=median(lv);
      medlv=[medlv;mlv];
      sv=(lv>=(mlv-1))&(lv<=(mlv+1));
      av=[av;atan2((yc(find(sv))-ycen),(xc(find(sv))-xcen))'];
   end;
end;

if length(av),
   av=(av<0).*(av+2*pi)+(av>=0).*av;
   av=(av>pi).*(av-pi)+(av<=pi).*av;
   medlv=mean(medlv);
   ang=median(av);
   
   tf=1;
   r=0;
   ps=0;
   
   [xc,yc,lv,v]=RETscan(x,th,xcen,ycen,r,ps,ang,2*medlv,dmin,vcmin,tf,dbf);
   
   if length(xc),
      dl=abs(lv-medlv);
      sv=dl==min(dl);
      
      %new
      ds=lv(find(sv));
      if length(ds)>1, ds=ds(1); end;
      %new end
      
      %ds=medlv;
      
      xc=xc(find(sv));
      yc=yc(find(sv));
      xl=fix([xc-ds/2*cos(ang+pi/2),xc+ds/2*cos(ang+pi/2)]);
      yl=fix([yc-ds/2*sin(ang+pi/2),yc+ds/2*sin(ang+pi/2)]);
      ec=1;
   else
      ec=0;
   end;
   
else
   ec=0;
end;

if dbf, disp('>>> Finished RETdiam2'); end;