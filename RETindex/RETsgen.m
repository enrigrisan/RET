%	---------------------------
%	- Function sgen          - 
%	---------------------------
%
% Salus index for the whole image
%
% Sintax:
%
% index = RETsgen(SEG structure, Flag Debug)
%


function s_finale=RETsgen(salusgrade,thsalus,dbf)

if dbf, disp('Inside RETsgen'); end;

if(~isempty(salusgrade)),   
   salusv=[salusgrade(:,1);salusgrade(:,2)];
   if salusv(find(salusv>thsalus))
      s_finale=mean(salusv(find(salusv>thsalus)));
   else
      s_finale=0;
   end;
else,
   s_finale=0;
end;

if dbf, disp('Finished RETsgen'); end;
      
