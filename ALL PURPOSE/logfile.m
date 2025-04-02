% FRK
% The function writes data to a text file
% v is the vector containing values to be saved
% fn is the file name; if omitted the user is prompted with a GUI for choosing the file name
% lab is a vector of labels to be put in front of values in v
% tit is a title to be written as a first line of the file


function logfile(v,fn,lab,tit);
pn=[];
if nargin<2 | ~length(fn),
   [fn,pn]=uiputfile('*.txt','Save as ...');
   fn
   if length(fn)<=4 | fn(length(fn)-3)~='.',
      fn=[fn,'.txt'];
   end;
   fn
end;
f=fopen([pn,fn],'a');
fprintf(f,'------------------------------------ \n');
if nargin>3,
   fprintf(f,[tit,'\n']);
   fprintf(f,'------------------------------------ \n');
end;
for ct=1:length(v),
   if nargin>2,
      fprintf(f,[lab(ct,:),' : %f \n'],v(ct));
   else
      fprintf(f,'%f \n',v(ct));
   end;
end;
fprintf(f,'------------------------------------ \n');
fclose(f);
