% RETmed
% Computes the median of the matrix x only where it's greater than zero.
% If there are not positive values, a median of -1 is returned.
% The -1 can then be used as flag

function m=RETmed(x)

ind=find(x~=-1);
if ~isempty(ind)
   m=median(x(ind));
else
   m=-1;
end
