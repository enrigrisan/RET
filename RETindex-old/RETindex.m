% ------------------------
% - Function RETindex -
% ------------------------
%
% Return the preliminary index of 
% hypertensive retinopathy
%
% Sintax:
%
%	index = RETindex(vascular index, non vascular index, gamma, debug flag)
%
% vascular index : scalar
% non vascular index : scalar
% gamma : combination function parameter


function index=RETindex(iv,inv,gamma,dbf);

index=gamma*(1-inv)*iv+inv;
