%	-------------------------
%	- Function togli_corti  -
%	-------------------------
%
% Look at th input seg structure, and it delete from
% it all the segments whose length (in pixels) is 
% less than the threshol value lungh_min
%
% Sintax:
% ---------
%
%	SEG_out = togli_corti(struttura SEG, soglia, flag debug)
%

function str_out = RETtogli_corti(str_in,lungh_min,dbg);

%if dbg, disp('>> Inside RETtogli_corti'); end;

n_segmenti = length(str_in);
dbgl=0;

if (dbg)
    disp(['number of segments',num2str(n_segmenti)]);
end;

ct2 = 1;
for ct = 1:n_segmenti,
      
    x = str_in(ct).x;
    y = str_in(ct).y;
    
    lunghezza  = RETl(x,y,1,dbgl);
    
    %inserisce il segmento corrente in str_out solo se e' lungo
    if ( lunghezza >= lungh_min ) 
        str_out(ct2)=str_in(ct);
        if (dbg)
            fprintf('seg%i - length=%f - inserted in %i\n',ct,lunghezza,ct2);
        end;
        
        ct2 = ct2+1;
        
    else
        if (dbg)
            fprintf('seg%i - length=%f -  deleted \n',ct,lunghezza);
        end;
    end;
    
end;

if (dbg == 1) 
    disp(['Now the output structure contains :',num2str(ct2),' elements.']);
    disp(['* end  togli_corti *']);
end;

%if dbg, disp('>> Finished RETtogli_corti'); end;
