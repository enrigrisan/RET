% -----------------------
% - Function RETchkbdbf -
% -----------------------
%
% checks if input beading corresponds to a cross point 
% if this is the case it is removed from the beading matrix 
%
% Sintax:
%
% beading out = RETchkbdbf(beading, bifcross, flag debug)
%
%

function beadingout = RETchkbdbf(nseg,beading,bifcross,dbf)

if dbf, disp('>> Inside RETchkbdbf'); end;

beadingout=[];
cttemp=1;
for ct=1:size(beading,1);
   bdresult=RETchkbdbifovrlp(nseg,beading(ct,1),beading(ct,2),bifcross,dbf);
   if ~bdresult,
      beadingout(cttemp,:)=beading(ct,:);
      cttemp=cttemp+1;
   end;
end;

if dbf, disp('>> Finished RETchkbdbf'); end;

