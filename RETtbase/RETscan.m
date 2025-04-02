function [xc,yc,lv,v]=RETscan(x,th,xcen,ycen,r,ps,ai,af,dmin,vcmin,tf,dbf)

if dbf, disp('>>> Inside RETscan'); end;

sx=size(x);

% profile coordinates determination (2 cases: arc or linear according to flag tf
if ~tf,
    ct=1;
    a=ai;
    ast=1/r;
    rplot=r;
    while a<=af,
        yv(ct)=round(r*sin(a)+ycen);
        xv(ct)=round(r*cos(a)+xcen);
        a=a+ast;
        ct=ct+1;
    end
else
    ct=1;
    
    xb=xcen+r*cos(ai);
    yb=ycen+r*sin(ai);
    xi=xb-af*cos(ai+pi/2);
    yi=yb-af*sin(ai+pi/2);
    xf=xb+af*cos(ai+pi/2);
    yf=yb+af*sin(ai+pi/2);
    
    d=sqrt((xi-xf)^2+(yi-yf)^2);
    
    %MF 20010329
    ni=fix(d*2);
    %MF 20010329
    
    stx=(xf-xi)/ni;
    sty=(yf-yi)/ni;
    xatt=xi;
    yatt=yi;
    
    while ct<=ni,
        xv(ct)=xatt;
        yv(ct)=yatt;
        xatt=xatt+stx;
        yatt=yatt+sty;
        ct=ct+1;
    end
    
end

% check for profile coordinates in admissible area
yv=fix(((yv>0)&(yv<=sx(1))).*yv);
ic=find(yv);
yv=yv(ic);
xv=xv(ic);
xv=fix(((xv>0)&(xv<=sx(2))).*xv);
ic=find(xv);
xv=xv(ic);
yv=yv(ic);

%profile acquisition from image
p=[];
for ct=1:length(xv);
    p(ct)=x(yv(ct),xv(ct));
end;

lp=length(p);

if lp
    if ~ps,
        ps=lp;
    end;
    
    % vessel fuzzy classification profile
    v=RETclass(p,ps,dbf);
    %
    %% thresholding
    vc=v>th;
    
    % vessel segmentation + non-vessel minimum distance suppression
    cont=1;
    r=1;
    indi=[];
    indf=[];
    nvc=1;
    while r<=lp,
        indi(cont)=r;
        indf(cont)=r;
        if vc(r)&(nvc<=(dmin+1))&(cont~=1), 
            cont=cont-1; 
        end;
        if vc(r),
            while r<lp&vc(r),
                indf(cont)=indf(cont)+1;
                r=r+1;
            end
            cont=cont+1;
            nvc=0;
        end;
        r=r+1;
        nvc=nvc+1;
    end
    
    %MF 20010323
    indf=indf-1;
    lvp=indf-indi+1;
    llvp=length(lvp);
    %MF 20010323
    
    % min diameter check + center and length determination
    nc=1;
    indc=[];
    xc=[];
    yc=[];
    lv=[];
    for ctvp=1:llvp,
        tlv=sqrt((xv(indi(ctvp))-xv(indf(ctvp)))^2+(yv(indi(ctvp))-yv(indf(ctvp)))^2);
        if tlv>=dmin,
            indc(nc)=ctvp;
            %xc(nc)=(xv(indi(ctvp))+xv(indf(ctvp)))/2;
            %yc(nc)=(yv(indi(ctvp))+yv(indf(ctvp)))/2;
            ns=sum(v(indi(ctvp):indf(ctvp)));
            xc(nc)=xv(indi(ctvp):indf(ctvp))*v(indi(ctvp):indf(ctvp))'/ns;
            yc(nc)=yv(indi(ctvp):indf(ctvp))*v(indi(ctvp):indf(ctvp))'/ns;
            lv(nc)=tlv;
            %lv(nc)=lvp(ctvp);
            nc=nc+1;
        end;
    end
    
    lindc=length(xc);
    
    % contrast check
    for ct=1:lindc,
        pini=indi(indc(ct));
        pf=indf(indc(ct));
        pini=fix(pini-lvp(indc(ct))/2);
        pf=fix(pf+lvp(indc(ct))/2);
        vtmp1=[];
        vtmp2=[];
        ptmp1=[];
        ptmp2=[];
        if pini<1,
            ptmp1=p(lp+pini:lp);
            vtmp1=v(lp+pini:lp);
            pini=1;
        end;
        if pf>lp,
            ptmp2=p(1:pf-lp);
            vtmp2=v(1:pf-lp);
            pf=lp;
        end;
        ptmp=[ptmp1,p(pini:pf),ptmp2];
        vtmp=[vtmp1,v(pini:pf),vtmp2];
        if RETcont(ptmp,vtmp)<vcmin,
            xc(ct)=0;
        end;
    end;
    
    ic=find(xc);
    xc=xc(ic);
    yc=yc(ic);
    lv=lv(ic);
    
    if dbf&lp,
        xvs=xv(find(vc));
        yvs=yv(find(vc));
        if tf, 
            h=line([xv(1),xv(lp)]',[yv(1),yv(lp)]'); 
            set(h,'color',[0,0,1]);
            lvs=length(xvs);
            
            for ctvp=1:llvp,
                indc(nc)=ctvp;
                h=line([xv(indi(ctvp)),xv(indf(ctvp))]',[yv(indi(ctvp)),yv(indf(ctvp))]');
                set(h,'color',[1,0,0]);
            end
            
            if lvs,
               h=line([xvs(1),xvs(lvs)]',[yvs(1),yvs(lvs)]');
               set(h,'color',[1,0,0]);
           end;
        else
            th=0:0.01:2*pi;
            h=gcf;
            hold on;
            plot(rplot*cos(th)+xcen,rplot*sin(th)+ycen,'k');
            %plot(xv,yv,'k');
            %plot(xvs,yvs,'oy');
        end;
    end;
    
%      if dbf,
%          h=gcf;
%          figure;
%          plot(p,'xb');
%          hold on;
%          plot(v,'og');
%          plot(vc,'*r');
%          figure(h);
%      end;
    
else
    xc=[];
    yc=[];
    lv=[];
    v=[];
end;

if dbf, disp('>>> Finished RETscan'); end;
