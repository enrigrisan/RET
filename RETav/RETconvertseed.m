
% -----------------------
% - Function RETconvert -
% -----------------------
%
% Converts the data in the text file exported from RETAnalysis
% into the seg structure used by Matlab modules.
% Every line in the text file represents the daa belonging to a field
% of an element of the seg structure.
%
% Sintax:
%
%	seg = RETconvert(nome file, flag debug)
%
% MM 2001-05-31
% EG 2001-05-31

function seed = RETconvertseed(nfile,dbf)

if nargin==1,
   dbf=0;
end;

if dbf,
   disp('Inside RETconvertseed');
end

seed=[];
[fid,message] = fopen(nfile,'r');
line   = fgetl(fid);
x=str2num(line);
line   = fgetl(fid);
y=str2num(line);
line   = fgetl(fid);
d=str2num(line);
line   = fgetl(fid);
dir=str2num(line);

for ct=1:length(x),
   seed(ct).x=x(ct);
   seed(ct).y=y(ct);
   seed(ct).d=d(ct);
   seed(ct).dir=dir(ct);
end;

fclose(fid);
if dbf,
   disp('Finished RETconvertseed');
end


