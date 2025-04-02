function [xc,yc,lv,v]=RETscanman(x,th,xcen,ycen,r,ps,ai,af,dmin,vcmin,nprof,dbf)

if dbf, disp('>>> Inside RETscan'); end;

sx=size(x);
memory=-(nprof-1):nprof-1;

d=2*af;
ni=fix(d*2);
for ctr=1:length(memory)
    
    ct=1;
    
    xb=xcen+(r+memory(ctr))*cos(ai);
    yb=ycen+(r+memory(ctr))*sin(ai);
    xi=xb-af*cos(ai+pi/2);
    yi=yb-af*sin(ai+pi/2);
    xf=xb+af*cos(ai+pi/2);
    yf=yb+af*sin(ai+pi/2);
    %d=sqrt((xi-xf)^2+(yi-yf)^2);
    %ni=fix(d*2);
    
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
    
    
    % check for profile coordinates in admissible area
  
    %disp(size(yv))
    yvtot(ctr,:)=fix(((yv>0)&(yv<=sx(1))).*yv);
    xvtot(ctr,:)=fix(((xv>0)&(xv<=sx(2))).*xv);
    %disp(size(yvtot))
end;

icy=find(all(yvtot,1));
xvtot=xvtot(:,icy);
yvtot=yvtot(:,icy);
icx=find(all(xvtot,1));
xvtot=xvtot(:,icx);
yvtot=yvtot(:,icx);

%profile acquisition from image
p=zeros(1,size(xvtot,2));
for ct1=1:size(xvtot,1)
    for ct2=1:size(xvtot,2);
        %disp([yvtot(ct1,ct2),xvtot(ct1,ct2)])
        p(ct2)=p(ct2)+x(yvtot(ct1,ct2),xvtot(ct1,ct2));
    end;
end;
p=p/size(xvtot,2);

lp=length(p);

if lp
    if ~ps,
        ps=lp;
    end;
    
    % vessel fuzzy classification profile
    v=RETclass(p,ps,dbf);
    
    % thresholding
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
        pin=indi(indc(ct));
        pf=indf(indc(ct));
        pin=fix(pin-lvp(indc(ct))/2);
        pf=fix(pf+lvp(indc(ct))/2);
        vtmp1=[];
        vtmp2=[];
        ptmp1=[];
        ptmp2=[];
        if pin<1,
            ptmp1=p(lp+pin:lp);
            vtmp1=v(lp+pin:lp);
            pin=1;
        end;
        if pf>lp,
            ptmp2=p(1:pf-lp);
            vtmp2=v(1:pf-lp);
            pf=lp;
        end;
        ptmp=[ptmp1,p(pin:pf),ptmp2];
        vtmp=[vtmp1,v(pin:pf),vtmp2];
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
        %if tf, 
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
            %else
            %plot(xvs,yvs,'ob');
            %end;
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
