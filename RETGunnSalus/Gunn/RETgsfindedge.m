% findedge
% Given the vectors der and dis, and the number of points in the vectors points,,
% Computes the four indexes that are supposed describing the crossing

function n=RETgsfindedge(dis,der,points,dbf);

if dbf,disp('Inside findedge'); end;

%find the four edge-points
disaux=dis;
proff=fnval(fnder(csaps([1:length(dis)+10],[dis,dis(1:10)],0.8),1),[1:0.1:length(dis)+10]);
l=2:length(proff)-1;
ntemp=find(proff(l-1)>0&proff(l+1)<0&proff(l)>=0);
ntemp=ntemp+1;
n=mod(round(ntemp/10),length(disaux));
if(~all(n))
   n(find(n==0))=length(disaux);
end;

ct=length(n);

%the following cycles are mutually exclusive

while(ct<4),
   for ct2=1:length(n)
      disaux=RETgunnaggiorna(disaux,n(ct2),points,1);
   end;
   n1(1)=n(end);
   n1(2:length(n))=n(1:end-1);
   sep=mod(n-n1,length(disaux));
   prova=find(sep==max(sep));
   prova=prova(1);
   if(n1(prova)>n(prova)),
      disauxt=disaux(n1(prova):end);
      disauxt(length(disaux)-n1(prova)+1:length(disaux)-n1(prova)+n(prova))=disaux(1:n(prova));
      ntemp=mod(find(disauxt==max(disauxt)),length(disaux));
   else
      ntemp=find(disaux(n1(prova):n(prova))==max(disaux(n1(prova):n(prova))));
   end;
   n(ct+1)=mod(ntemp(1)+n1(prova)-1,length(disaux));
   ct=ct+1;
end;

while(ct>4),
   n1=[];
   n2=[];
   n1(1)=n(end);
   n1(2:length(n))=n(1:end-1);
   n2=n(2:end);
   n2(length(n))=n(1);
   sep=mod(n2-n1,length(disaux));
   prova=find(sep==min(sep));
   switch(prova(1)),
   case{1}
      n=n(2:length(n));
   case{length(n)}
      n=n(1:end-1);
   otherwise
      nt1=n(1:prova(1)-1);
      nt2=n(prova(1)+1:end);
      n=[nt1,nt2];
   end;
   ct=ct-1;
end;

n=sort(n);
if(n(1)==0),
   n=[n(2):length(n),length(disaux)];
end;

if dbf, disp('Finished findedge'); end;