%	------------------------
%	- Function RETbeading -
%	------------------------
%
% Update the input seg structure,
% adding informations about beading. 
%
% Updating :
%
%  - for every segment the index var(diam)/(mean(diam)*length(segmento))
%    is computed, and this is used as reliability measure:
%    thresholding is based on this feature
%
%  - The beading corresponding to a cross point are removed
%
% Sintax:
%
%	seg_out = RETbeading(seg_in, parameters,dbf)
%
% MM
% EG 2001-06-14

function segbead= RETbeading(seg,bifcross,options,dbf)

if dbf, disp('Inside RETbeading'); end;

idamax=options.idamax;
minves=options.minveslength;

num_segmenti=length(seg);

segbead=seg;

for ct = 1:num_segmenti,      
    if dbf
        disp(['- Segmento n.:',num2str(ct)]);
    end;
    if (seg(ct).l>minves),
        t = RETparam(segbead(ct).x,segbead(ct).y,dbf);
        d = segbead(ct).d;
        l = segbead(ct).l;
        ida = 1000*var(d)/(mean(d)*l);
        if (ida>idamax),
            if dbf,
                disp(['> Ida segmento :',num2str(ct),' >>',num2str(ida),'>> Segmento non considerato']);
            end;
            segbead(ct).b=[];  
        else
            segbead(ct).b=RETbeading_seg(t,d',l,ct,bifcross,options,dbf);
        end;
    else     
        segbead(ct).b=[]; 
    end;  
end;

if dbf, disp('Ending RETbeading'); end;