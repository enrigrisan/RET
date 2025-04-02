
% RETeliminaspikes
% Given the input binary vector vect_in, insulated ones or zeros are
% filtered out, according to the minimum transition length fin, which is 
% can be viewed as the filtering window

function vect_out=RETelimiaspikes(vect_in,fin,dbf);

if(dbf)
   disp('Inside RETeliminaspikes');
end;


vect_out=medfilt1(vect_in,fin);

if(dbf)
   disp('Finished RETeliminaspikes');
end;


