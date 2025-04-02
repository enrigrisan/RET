%	---------------------------
%	- Function ggen          - 
%	---------------------------
%
% Gunn index for the whole image
%
% Sintax:
%
% index = RETggen(SEG structure, Flag Debug)
%


function g_finale= RETggen(gunngrade,dbf)

if dbf, disp('Inside RETggen'); end;

if(~isempty(gunngrade)),
   gunngrade(find(gunngrade<0))=0;
   n=find(all(gunngrade,2));
   gunngrade(n,:)=0;
   g_finale=sum(sum((gunngrade>0).*gunngrade));
else,
   g_finale=0;
end;

if dbf, disp(' Finished RETggen'); end;
      
