function sega=createsega(seg,index,dbf);

if(dbf),
   disp('Inside createsega');
end;

if(isempty(index)),
   sega=seg;
else,
   for ct=1:length(index),
      sega(ct)=seg(index(ct));
   end; 
end;

if(dbf),
   disp('Finished createsega');
end;