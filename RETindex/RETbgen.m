%	---------------------------
%	- Function bgen          - 
%	---------------------------
%
% Beading computation for the whole image
%
% Sintax:
%
% index = RETbgen(SEG structure, Flag Debug)
%
function bead_finale=RETbgen(seg,par,dbf)

if dbf, disp('Inside RETbgen'); end;

num_segmenti=length(seg);
w=0;
b=[];
for ct=1:num_segmenti,
    if(~isempty(seg(ct).b)),
        beading=seg(ct).b;
        for ct2=1:size(beading,1),
            w=w+1;
            b(w)=RETsigmoid(beading(ct2,5),par,dbf);
        end;
    end;
end;

if(~isempty(b)),
    %bead_finale=[sum(b.^2)/sum(b),sum(b)];
    bead_finale=sum(b);
else,
    %bead_finale=[0,0];
    bead_finale=0;
end;

if dbf, disp('Finished RETbgen'); end;