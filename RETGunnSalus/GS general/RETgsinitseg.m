% Initialize a seg structure for inserting the gunn and salus indexes 

function seg_out=RETgsinitseg(seg_in,dbf);

if(dbf)
   disp('Inside initseggs');
end;

seg_out=seg_in;

for ct=1:length(seg_in),
   seg_out(ct).g=[];
   seg_out(ct).s=[];
end;

if(dbf)
   disp('Exit initseggs');
end;
