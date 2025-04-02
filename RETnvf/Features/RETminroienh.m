function [xroi,rroi,croi]=RETminroienh(x,dbf);

% RETMINROIENH  Selects a rectangular image around the region of
%            interest
%   [XROI,RROI,CROI] = RETMINROIENH(X,DBF)
%   XROI is the binary image of the region of interest
%   RROI is a vector containg the references to the first and 
%   last rows of the roi related to X.
%   CROI is a vector containg the references to the first and 
%   last columns of the roi related to X.
%   It takes the minimum roi containing the blob in X and then
%   enlarge it by adding 2*radii. This to ensure a proper space
%   for calculating border features.
%
%   ADL 2001-02-13.
%   EG  2001-05-21

if dbf, disp('Inside RETminroienh'); end;

sx=size(x);
[r,c]=find(x);
r1=min(r); c1=min(c);
r2=max(r); c2=max(c);

radii=ceil(sqrt(sum(sum(x))/pi));

rroi=[max(1,r1-radii),min(r2+radii,sx(1))];
croi=[max(1,c1-radii),min(c2+radii,sx(2))];
xroi=double(x(rroi(1):rroi(2),croi(1):croi(2)));

if dbf, disp('Finished RETminroienh'); end;










