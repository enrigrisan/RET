% ----------------------------
% - Function RETchkbdbfovrlp -
% ----------------------------
%
% Returns 1 if a crossing occurs in the beading zone, 0 otherwise
%
%
% Sintax:
%
%	result = RETchkbdbifovrlp(n. segmento, indice bead. start, indice bead. end, bifcross, flag debug)
%

function boolresult=RETchkbdbifovrlp(nseg,indbdstart,indbdend,bifcross,dbf)

if dbf, disp('>> Inside RETchkbdbifovrlp'); end;

boolresult=0;
numcross=length(bifcross);

for ct=1:numcross,
    if (nseg==bifcross(ct).s1),
        if (bifcross(ct).i1 >= indbdstart) & (bifcross(ct).i1 <= indbdend),
            if dbf,
                disp(['Beading overlapping cross n.:',num2str(ct)]);
            end;
            boolresult =1;
        end;
    end;
    if (nseg==bifcross(ct).s2),
        if (bifcross(ct).i2 >= indbdstart) & (bifcross(ct).i2 <= indbdend),
            disp(['Beading overlapping cross n.:',num2str(ct)]);
            boolresult =1;
        end;
    end;
end;

if dbf, disp('>> Finished RETchkbdbifovrlp'); end;



