% ------------------------
% - Function RETnvfindex -
% ------------------------
%
% Return the preliminary index of 
% non vascular pathologies
%
% Sintax:
%
%	NVFindex = RETnvfindex(nvf structure, coeff. norm., param. struct, debug flag)
%
% nvf = structure of non vascular features
% coeff = 1x1 double
% weight = weight vector 1xN, with N the number of pathology sign
% par    = struct containing the sigmoids parameters


function [index,acchaem,accexud,acccws]=RETnvfindex(nvf,coeff,weight,par,dbf)

if dbf, disp('Inside RETnvpindex'); end;

if dbf,
   disp(['Normalizing Area ...']);
end;

for ct=1:length(nvf),
   nvf(ct).area=nvf(ct).area/(coeff^2);
end;

% variables initialization 
acccws  = 0;
acchaem = 0;
accexud = 0;

for ct=1:length(nvf),
   acchaem=acchaem+(nvf(ct).p(1)*nvf(ct).area);
   accexud=accexud+(nvf(ct).p(2)*nvf(ct).area);
   acccws=acccws+(nvf(ct).p(3)*nvf(ct).area);
end;

if dbf,
   disp(['Index of haemorrages :',num2str(acchaem)]);
   disp(['Index of exudates    :',num2str(accexud)]);
   disp(['Index of c. w. spots :',num2str(acccws)]);
end;

global_nvf=sum(weight.*[acccws,accexud,acchaem])/sum(weight);
s_reliability=RETsigmoid(global_nvf,par.reliability,dbf);
s_level=RETsigmoid(global_nvf,par.level,dbf);

index=s_reliability*s_level;

if dbf, disp('Finished RETnvpindex'); end;