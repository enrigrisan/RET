% ---------------------
% - Function RETvindex -
% ---------------------
%
% Return the preliminary index of vascular pathology
%
% Sintax:
%
%	y = Retvindex(indexes,weight,par,dbf) 
%
% indexes: struct containing the separate vascular indexes:
% 				tortuosity = 1x1 double
% 				gennar = 1x1 double
% 				beading= 1x1 double
% 				gunn = 1x1 double
% 				salus= 1x1 double
% weight : struct containing the weights of the different vascular indexes for the
%          weighted average
% par    : struct of 1x4 array containing the sigmoid parameters for the different
%          vascular indexes


function [index,vindex]=RETvindex(indexes,weight,par,dbf)

if dbf, disp(['inside RETvindex']); end;

%Tortuosity
indt=RETsigmoid(indexes.tortuosity,par.tortuosity,dbf);

%Beading
indb=RETsigmoid(indexes.bead,par.bead,dbf);
if indb==0,
   weight(3)=0;
end;


%Narrowing
indng=RETsigmoid(indexes.gennar,par.gennar(1:4),dbf);
if indng<par.gennar(5),
   weight(2)=0;
end;

%Gunn
if indexes.gunn==0,
   indgunn=0;
   weight(4)=0;
else,
   indgunn=RETsigmoid(indexes.gunn,par.gunn,dbf);
end;

%Salus
if indexes.salus==0,
   indsalus=0;
   weight(5)=0;
else,
   indsalus=RETsigmoid(indexes.salus,par.salus,dbf);
end;
   
vindex=[indt,indng,indgunn,indsalus,indb];

index=sum(weight.*vindex)/sum(weight);

if dbf,
   disp(['Index of tortuosity :',num2str(indt)]);
   disp(['Index of general narrowing :',num2str(indng)]);
   disp(['Index of focal narrowing :',num2str(indb)]);
   disp(['Index of Gunn''s sign presence:',num2str(indgunn)]);
   disp(['Index of Salus'' sign presence:',num2str(indsalus)]);
   disp('---------------------------------------------------');
   disp(['GENERAL INDEX :',num2str(index)]);
end;
                     
if dbf, disp('Finished RETvindex'); end;