%	---------------------------
%	- Function tgen          - 
%	---------------------------
%
% Tortuosity computation for the whole image
%
% Sintax:
%
% index = RETtgen(SEG structure, Flag Debug)
%

function t0_finale=RETtgen(seg,dbf)

if dbf, disp('Inside RETtgen'); end;

num_segmenti=length(seg);

ltot = 0;
for i=1:num_segmenti,
    ltot=ltot+seg(i).l;
end

t0_finale = 0;
for i = 1:num_segmenti,
    t0_finale=t0_finale+seg(i).l*seg(i).t;
end;

t0_finale=t0_finale/ltot;

if dbf, 
    disp(['Tortuosity index for the whole network ',inputname(1),' :',num2str(t0_finale)]);
    disp(['total network length is :',num2str(ltot)]); 
end;

if dbf, disp('Finished RETtgen'); end;

