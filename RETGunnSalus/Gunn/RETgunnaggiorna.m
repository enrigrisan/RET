% It update the disaux vector to insure a proper separation between
% subsequent choice of the points defining the cross
function [disaux]=RETgunnaggiorna(disaux,n,points,dbf);

sep=fix(points/7);
if(dbf),disp('Inside aggiorna');end;
%disp(n-sep)
if((n-sep)==0),
   disaux(1:n+sep)=0;
   disaux(length(disaux)-sep:length(disaux))=0;
elseif((n-sep)<1),
   disaux(1:n+sep)=0;
   disaux(mod(n-sep,length(disaux)):length(disaux))=0;
elseif(n+sep>=length(disaux))
   disaux(n-sep:length(disaux))=0;
   disaux(1:n+sep-length(disaux))=0;
else,
   disaux(n-sep:n+sep)=0;
end;
if(dbf),disp('Finished aggiorna');end;