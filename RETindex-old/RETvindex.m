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

%Narrowing
indng=RETsigmoid(indexes.gennar,par.gennar(1:4),dbf);

%Gunn
if isempty(indexes.gunn),
   indgunn=0;
   weight(4)=0;
else,
   indgunn=RETsigmoid(indexes.gunn,par.gunn,dbf);
end;

%Salus
if isempty(indexes.salus),
   indsalus=0;
   weight(5)=0;
else,
   indsalus=RETsigmoid(indexes.salus,par.salus,dbf);
end;
   
vindex=[indt,indng,indb,indgunn,indsalus];

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