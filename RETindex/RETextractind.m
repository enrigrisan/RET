% RETextractind(segs5,segs4,segs5,segs4,scale,dbf)
% Extracts the whole image pathology indexes for the 
% different pathologic sign

function indexes=RETextractind(segbead,segtort,gunngrade,salusgrade,narr,coeff,thsalus,bgen,dbf)

if dbf, disp('Inside RETextractin'); end;

%Tortuosity
indexes.tortuosity=RETtgen(segtort,dbf);

%Narrowing
indexes.gennar=narr;

%Beading
indexes.bead=RETbgen(segbead,bgen,dbf);

%Gunn and Salus
if isempty(gunngrade),
   indexes.gunn=0;
else,
   indexes.gunn=RETggen(gunngrade,dbf);
end;

if isempty(salusgrade),
   indexes.salus=0;
else,
   indexes.salus=RETsgen(salusgrade,thsalus,dbf);
end;


if dbf, disp('Finished RETextractin'); end;

