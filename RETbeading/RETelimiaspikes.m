
% RETeliminaspikes
% Given the input binary vector vect_in, insulated ones or zeros are
% filtered out, according to the minimum transition length fin, which is 
% can be viewed as the filtering window

function y=RETelimiaspikes(x,fin,dbf);

if dbf, disp('Inside RETeliminaspikes'); end;

y=RETrnkfilter(x,50,fin,dbf);

if dbf, disp('Finished RETeliminaspikes'); end;


