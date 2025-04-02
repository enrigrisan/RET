function [classvec,xclust,yclust]=RETCclfix(classvec,xself,yself,xclust,yclust,mindist,mindistn,mne,dbf);
if dbf, disp('>>> Inside RETCclfix'); end;

nc=max(classvec);

% flag matrix for determination of closely neighboring clusters (countign the numbers of pixels verifying distance relation)
fm=zeros(nc,nc);
mdist=zeros(nc,nc);
for ctc1=1:nc-1,
   for ctc2=ctc1+1:nc,
      ic1=find(classvec==ctc1);
      lic1=length(ic1);
      ic2=find(classvec==ctc2);
      lic2=length(ic2);
      dm=(xself(ic1)*ones(1,lic2)-ones(lic1,1)*xself(ic2)').^2+(yself(ic1)*ones(1,lic2)-ones(lic1,1)*yself(ic2)').^2;
      mdist(ctc1,ctc2)=sqrt(min(min(dm)));
      condm=dm<(mindist^2);
      if any(any(condm)),
         fm(ctc1,ctc2)=sum(sum(condm));
      end;
   end;
end;

% setting flag matrix for cluster couples with a number of close elements greater than the limit mindistn
fm=fm>mindistn;

tf=~any(any(fm));
while ~tf,
   [ic1,ic2]=find(fm);
   if length(ic1),
      ic1=ic1(1);
      ic2=ic2(1);
      
      if ic1>ic2, 
         tmp=ic1;
         ic1=ic2; 
         ic2=tmp;
      end;
      
      classvec(find(classvec==ic2))=ic1;
      ic=find(classvec>ic2);
      classvec(ic)=classvec(ic)-1;
      
      fm(ic1,:)=fm(ic1,:)|fm(ic2,:);
      fm(:,ic1)=fm(:,ic1)|fm(:,ic2);
      fm(ic1,ic1)=0;
      
      fm(ic2,:)=[];
      fm(:,ic2)=[];
      
      xclust(ic2)=[];
      yclust(ic2)=[];
   else
      tf=1;
   end;
end;

%suppression of clusters with insufficient number of elements
nc=max(classvec);
classvecn=classvec;
for ctc=1:nc,
   np(ctc)=sum(classvec==ctc);
     if np(ctc)<mne,
        ic=find(classvec==ctc);
        classvecn(ic)=0;
        ic=find(classvec>ctc);
        classvecn(ic)=classvecn(ic)-1;
     end;
 end;
classvec=classvecn;

ic=find(np'>=mne);
xclust=xclust(ic);
yclust=yclust(ic);


%if dbf,
%   mdist
%   max(max(classvec))
%   xclust
%   yclust
%   pause;
%end;



if dbf, disp('>>> Finished RETCclfix'); end;

   