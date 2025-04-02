% RETsdev
% Computes the standard deviation of matrix x only where it's greater than
% zero. If no positive values are present, the standard deviation is set to -1.
% This value is used as non-presence flag

function sd=RETsdev(x)

ind=find(x~=-1);
if ~isempty(ind)
   sd=std(x(ind));
else
   sd=-1;
end
