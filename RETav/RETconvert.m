
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

function seg = RETconvert(nfile,dbf)

if nargin==1,
   dbf=0;
end;

if dbf,
   disp('Inside RETconvert');
end

seg=[];
[fid,message] = fopen(nfile,'r');
line   = fgetl(fid);
numseg = str2num(line);
%disp(['Numero segmenti :',num2str(line)]);
for ct = 1:numseg,
   if(dbf),disp(ct);end;
   seg(ct).x = sscanf(fgetl(fid),'%f');
   seg(ct).x = seg(ct).x(1:end-1)+1;
   seg(ct).y = sscanf(fgetl(fid),'%f');
   seg(ct).y = seg(ct).y(1:end-1)+1;
   seg(ct).d = sscanf(fgetl(fid),'%f');
   seg(ct).d = seg(ct).d(1:end-1);
   seg(ct).dir = sscanf(fgetl(fid),'%f');
   seg(ct).dir = seg(ct).dir(1:end-1);
   seg(ct).ec  = [0,0];
end;
fclose(fid);
if dbf,
   disp('Finished RETconvert');
end


