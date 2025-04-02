function [classvec,xclust,yclust]=RETBclust(xself,yself,xc,yc,fth,dbf);
if dbf, disp('>>> Inside RETBclust'); end;

sxself=size(xself,1);

[th,r]=cart2pol(xself-xc,yself-yc);

%temporarily disabled th
pts=[xself,yself,th];

%subclust options (set by BM)
op=[1,0.9,0.15,0];

%subclust radii (set by BM)
radii=[0.4,0.4,0.2];

%subclust xbounds
xbounds(1,1)=min([min(xself);min(yself)]);
xbounds(2,1)=max([max(xself);max(yself)]);
xbounds(:,2)=xbounds(:,1);
xbounds(:,3)=[-pi;pi];

%[c,s]=subclust(pts,radii,xbounds,op);
[c,s]=subclust(pts,radii,xbounds,op);
nclust=size(c,1)+1;

%fcm options (set by BM)
[center,u,obj_fcn]=fcm3(pts,nclust);

nc=size(center,1);

if nc
   xclust=center(:,1);
   yclust=center(:,2);
   
   classvec=zeros(sxself,1);
   
   for ct=1:sxself,
      mu=max(u(:,ct)');
      if mu>fth,      
         i=find(u(:,ct)==mu);
         i=i(1);
         classvec(ct)=i;
      end;   
   end
   
   for ctc=1:nc,
      np(ctc)=sum(classvec==ctc);
   end;
   
   ef=0;
   ctc=1;
   while ~ef,
       if ~np(ctc),
           np(ctc)=[];
           xclust(ctc)=[];
           yclust(ctc)=[];
           i=find(classvec>ctc);
           classvec(i)=classvec(i)-1;
       else
           ctc=ctc+1;
       end;
       ef=ctc>length(xclust);
   end;
       
else
   xclust=[];
   yclust=[];
   classvec=[];
end

if dbf, disp('>>> Finished RETBclust'); end;
