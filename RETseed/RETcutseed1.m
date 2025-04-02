function  rseeds=RETcutseed1(seeds,dmin,img,glfilt,dbf);

if dbf, disp('Inside RETcutseed1'); end;

dmin=dmin^2;
sxs=length(seeds);

[xs,ys,ds,dirs]=RETseedsextract(seeds,dbf);

dist=(xs*ones(1,sxs)-ones(sxs,1)*xs').^2+(ys*ones(1,sxs)-ones(sxs,1)*ys').^2;
dist=dist+(dmin+1)*eye(sxs);

iout=[];
isel=[];

ct1=1;
vd1=min(dist);
[vds1,isort1]=sort(vd1);

for ct1=1:sxs,
    i1=isort1(ct1);
    if length(iout)==0|~any(iout==i1);
        ms=[i1];
        vd2=dist(i1,:);
        [vds2,isort2]=sort(vd2);
        for ct2=1:sxs,
            if length(iout)==0|~any(iout==isort2(ct2));
                f=1;
                for ct3=1:length(ms),
                    f=f&dist(ms(ct3),isort2(ct2))<dmin;
                end;
                if f, ms=[ms;isort2(ct2)]; end;
            end;
        end;
        gl=[];
        for ct4=1:length(ms),
            gl(ct4)=graylev(img,xs(ms(ct4)),ys(ms(ct4)),glfilt);
        end;
        is=find(gl==min(min(gl)));
        if length(is)>1,
            is=is(1);
        end;
        isel=[isel;ms(is)];
        iout=[iout;ms];
        
        %         if dbf,
        %             sims(img);
        %             hold on;
        %             plot(xs(ms),ys(ms),'xb');
        %             plot(xs(ms(is)),ys(ms(is)),'og');
        %             disp('PRESS ANY KEY TO CONTINUE');
        %             pause;
        %             close;
        %         end;
        
        if dbf, disp(sprintf('Seed %i of %i',ct1,sxs)); end;        
    end;
end;

rseeds=seeds(isel);

function m=graylev(img,x,y,glfilt),
lh=(length(glfilt)-1)/2;
[nr,nc]=size(img);
xl=max(x-lh,1);
xh=min(x+lh,nc);
yl=max(y-lh,1);
yh=min(y+lh,nr);
a=[zeros(1,xl-x+lh),img(y,xl:xh),zeros(1,x+lh-xh)];
b=[zeros(1,yl-y+lh),img(yl:yh,x)',zeros(1,y+lh-yh)];
m=(a*glfilt'+b*glfilt')/(2*sum(glfilt));

% Forak old
% isel=[];
% 
% f=1;
% while f,
%     mindist=min(min(dist))
%     [i1,i2]=find(dist==mindist);
%     if mindist<dmin,
%         if length(i1)>1.
%             i1=i1(1);
%             i2=i2(1);
%         end;
%         mgl1=graylev(img,xs(i1),ys(i1),glfilt);
%         mgl2=graylev(img,xs(i2),ys(i2),glfilt);
%         if mgl1<mgl2,
%             isel=[isel;i1];
%             dist(i2,:)=dmin+1;
%             dist(:,i2)=dmin+1;
%         else
%             isel=[isel;i2];
%             dist(i1,:)=dmin+1;
%             dist(:,i1)=dmin+1;
%         end;
%     else
%         f=0;
%     end;
% end;
% 
% isel=sort(isel);
% isel2=isel(1);
% k=1;
% for ct=2:length(isel);
%     if isel(ct)~=isel2(k),
%         k=k+1;
%         isel2(k)=isel(ct);
%     end;
% end;

%De Luca old
% s=[];
% t=1;
% 
% for i=1:np,
%     p=find(dist(i,1:np)< dmin & dist(i,1:np)>=0);
%     if length(p)>0,
%         for k =1:length(p),
%             c(k)=mediagrigi(img,xs(p(k)),ys(p(k)),h);
%             dist(1:np,p(k))=-ones(np,1);
%             dist(p(k),1:np)=-ones(1,np);
%         end;
%         m=find(c==min(c));
%         clear c;
%         s(t)=p(m(1));
%         t=t+1;
%     end;
% end;
% 
% for i=1:length(s),
%     x(i)=xs(s(i));
%     y(i)=ys(s(i));
%     diametri(i)=diam(s(i));
% end;
% 
% if dbf, disp('Finished RETcutseed1'); end;
% 
% 
% 
% function m=mediagrigi(img,x,y,h),
% lh=(length(h)-1)/2;
% 
% [nr,nc]=size(img);
% l=max(x-lh,1);
% r=min(x+lh,nc);
% u=max(y-lh,1);
% d=min(y+lh,nr);
% a=img(y,l:r);
% b=img(u:d,x);
% m=1;
% 
% if l>1 & r<nc & u>1 & d<nr, 
%     m=(a*h'+b'*h')/(2*length(h));
% end;
