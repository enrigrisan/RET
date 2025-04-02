% It update the disaux vector to insure a proper separation between
% subsequent choice of the points defining the cross
function [disaux]=RETgunnaggiorna(disaux,n,points,dbf);

if dbf, disp('Inside aggiorna'); end;

if((n-points/7)<1),
   disaux(1:n+points/7)=0;
   disaux(mod(n-points/7,length(disaux)):length(disaux))=0;
elseif(n+points/7>=length(disaux))
   disaux(n-points/7:length(disaux))=0;
   disaux(1:n+points/7-length(disaux))=0;
else,
   disaux(n-points/7:n+points/7)=0;
end;

if dbf, disp('Finished aggiorna'); end;