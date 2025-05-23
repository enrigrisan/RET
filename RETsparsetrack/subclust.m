function [centers,sigmas] = subclust(X,radii,xBounds,options)
%SUBCLUST Find cluster centers with subtractive clustering.
%	Usage of this function is [C,S] = SUBCLUST(X,RADII,XBOUNDS,OPTIONS).
%	For a matrix X in which each row contains a data point, this function
%	estimates the cluster centers by using the "Subtractive Clustering
%	Method".  RADII is a vector that specifies a cluster center's range of
%	influence in each of the data dimensions, assuming the data falls
%	within a unit hyperbox.  For example, if the data dimension is 2
%	(X has 2 columns), RADII = [0.5 0.25] specifies that the range of
%	influence in the first data dimension is half the width of the data
%	space and the range of influence in the second data dimension is one
%	quarter the width of the data space.  If RADII is a scalar, then the
%	scalar value is applied to all data dimensions, i.e., each cluster 
%	center will have a spherical neighborhood of influence with the given
%	radius.  XBOUNDS is a 2xN matrix that specifies how to map the data in
%	X into a unit hyperbox, where N is the data dimension.  The first row
%	contains the minimum axis range values and the second row contains the
%	maximum axis range values for scaling the data in each dimension.
%	For example, XBOUNDS = [-10 -5; 10 5] specifies that data values in the
%	first data dimension are to be scaled from the range [-10 +10] into
%	values in the range [0 1]; data values in the second data dimension are
%	to be scaled from the range [-5 +5] into values in the range [0 1].
%	If XBOUNDS is an empty matrix or not provided, then XBOUNDS defaults
%	to the minimum and maximum data values found in each data dimension.
%
%	OPTIONS is an optional vector for specifying clustering algorithm
%	parameters to override the default values.  These parameters are:
%	OPTIONS = [SQUASH_FACTOR ACCEPT_RATIO REJECT_RATIO VERBOSE].
%	SQUASH_FACTOR is used to multiply the RADII values to determine the
%	neighborhood of a cluster center within which the existence of other
%	cluster centers are to be discouraged.  For each data point, a measure
%	of its potential as a cluster center is computed.  The data point with
%	the highest potential is selected as the first cluster center.
%	ACCEPT_RATIO sets the potential, as a fraction of the potential of the
%	first cluster center, above which another data  point will be accepted
%	as a cluster center.  REJECT_RATIO sets the potential, as a fraction of
%	the potential of the first cluster center, below which a data point will
%	be rejected as a cluster center.  If VERBOSE is not zero, then progress
%	information will be printed as the clustering process proceeds.
%	The default values for the parameters in the OPTIONS vector are
%	[1.25 0.5 0.15 0].  The function returns the cluster centers in the
%	matrix C; each row of C contains the position of a cluster center.
%	The returned S vector contains the sigma values that specify the range
%	of influence of a cluster center in each of the data dimensions.
%	All cluster centers share the same set of sigma values.
%
%	Examples:
%
%	[C,S] = SUBCLUST(X,0.5)
%	This is the minimum number of argument needed to use this function.
%	Here a range of influence of 0.5 is specified for all data dimensions.
%
%	[C,S] = SUBCLUST(X,[0.5 0.25 0.3],[],[2.0 0.8 0.7])
%	This assumes the data dimension is 3 (X has 3 columns) and uses a
%	range of influence of 0.5, 0.25, and 0.3 for the first, second
%	and third data dimension, respectively.  The scaling factors for
%	mapping the data into a unit hyperbox will be obtained from the minimum
%	and maximum data values.  The SQUASH_FACTOR is set to 2.0, indicating
%	that we want to only find clusters that are far from each other;
%	the ACCEPT_RATIO is set to 0.8, indicating that we will only accept
%	data points that have very strong potential of being cluster centers;
%	the REJECT_RATIO is set to 0.7, indicating that we want to reject all
%	data points without a strong potential.
%
%	A full description of the clustering algorithm can be found in: 
%	S. Chiu, "Fuzzy Model Identification Based on Cluster Estimation," J. of
%	Intelligent & Fuzzy Systems, Vol. 2, No. 3, 1994.
%
%	See also GENFIS2.

%   Steve Chiu, 1-25-95
%   Roger Jang, 2-26-96, replace some for-loops with vectorized codes
%   Copyright 1994-2000 The MathWorks, Inc. 
%   $Revision: 1.14 $  $Date: 2000/07/19 17:25:03 $

[numPoints,numParams] = size(X);

if nargin < 4
	options = [1.25 0.5 0.15 0];
end

if nargin < 3
	xBounds = [];
end

% if only one value is given as the range of influence, then apply that
% value to all data dimensions 
if length(radii) == 1 & numParams ~= 1
	radii = radii * ones(1,numParams);
end

sqshFactor = options(1);
acceptRatio = options(2);
rejectRatio = options(3);
verbose = options(4);

% distance multipliers for accumulating and squashing cluster potentials
accumMultp = 1.0 ./ radii;
sqshMultp = 1.0 ./ (sqshFactor * radii);

if verbose
	disp('Normalizing data...');
end

if length(xBounds) == 0
	% no data scaling range values are specified, use the actual minimum and
	% maximum values of the data for scaling the data into a unit hyperbox
	minX = min(X);
	maxX = max(X);
else
	minX = xBounds(1,:);
	maxX = xBounds(2,:);
end

% normalize the data into values between 0 and 1
for i=1:numParams
	X(:,i) = (X(:,i) - minX(i)) / (maxX(i) - minX(i));
end
X = min(max(X,0),1);

if verbose
	disp('Computing potential for each data point...');
end

% potVals = the potential of each data point to be a cluster center
potVals = zeros(1,numPoints);

% compute the initial potentials for each data point
%for i=1:numPoints
%	thePoint = X(i,:);
%	% potVals(i) is the potential of the i'th data point
%	potVals(i) = potVals(i) + 1.0;  % add 1.0 for being close to yourself
%
%	for j=(i+1):numPoints
%		nextPoint = X(j,:);
%		dx = (thePoint - nextPoint) .* accumMultp;
%		dxSq = dx * dx';
%		mu = exp(-4.0 * dxSq);
%
%		potVals(i) = potVals(i) + mu;
%		potVals(j) = potVals(j) + mu;
%	end	% endfor j=(i+1):numdata
%
%end	% end for i=1:numdata

% compute the initial potentials for each data point
% Vectorized version by Roger Jang, 2-26-96
new_accumMultp = accumMultp(ones(1,numPoints),:);
UseWaitBar = (numPoints > 500);
if UseWaitBar
	h = waitbar(0,'Please wait...');
end

for i=1:numPoints,
	thePoint = X(i,:);
	thePoint = thePoint(ones(1,numPoints),:);
	dx = (thePoint - X) .* new_accumMultp;
	if numParams == 1,
		potVals(i) = sum(exp(-4*dx.^2));
	else
		potVals(i) = sum(exp(-4*sum(dx.^2,2)));
	end
	if UseWaitBar & mod(i,100)==0
		waitbar(i/numPoints);
	end 
end

if UseWaitBar
	close(h)    
end

% Find the data point with highest potential value.  refPotVal is the
% highest potential value, used as a reference for accepting/rejecting
% other data points as cluster centers.
[refPotVal,maxPotIndex] = max(potVals);

% Start iteratively finding cluster centers and subtracting potential
% from neighboring data points.  maxPotVal is the current highest
% potential value and maxPotIndex is the associated data point's index.
maxPotVal = refPotVal;

% centers = the cluster centers that has been found
centers = [];
numClusters = 0;
findMore = 1;

while findMore & maxPotVal
	findMore = 0;
	maxPoint = X(maxPotIndex,:);
	maxPotRatio = maxPotVal/refPotVal;

	if maxPotRatio > acceptRatio
		% the new peak value is significant, accept it
		findMore = 1;
	elseif maxPotRatio > rejectRatio
		% accept this data point only if it achieves a good balance between having
		% a reasonable potential and being far from all existing cluster centers
		minDistSq = -1;

		for i=1:numClusters
			dx = (maxPoint - centers(i,:)) .* accumMultp;
			dxSq = dx * dx';

			if minDistSq < 0 | dxSq < minDistSq
				minDistSq = dxSq;
			end
		end	% end for i=1:numClusters

		minDist = sqrt(minDistSq);
		if (maxPotRatio + minDist) >= 1
			findMore = 1;	% tentatively accept this data point as a cluster center
		else
			findMore = 2;	% remove this point from further consideration, and continue
		end
	end	% end if maxPotRatio > acceptRatio

	if findMore == 1
		% add the data point to the list of cluster centers
		centers = [centers ; maxPoint];
		numClusters = numClusters + 1;

		if verbose
			msg = sprintf('Found cluster %g, potential = %g',numClusters,maxPotRatio);
			disp(msg);
		end

		% subtract potential from data points near the new cluster center
%		for i=1:numPoints
%			nextPoint = X(i,:);
%			potVal = potVals(i);
%			dx = (maxPoint - nextPoint) .* sqshMultp;
%   			dxSq = dx * dx';
%
%			potVal = potVal - (maxPotVal * exp(-4.0 * dxSq));
%			if potVal < 0
%				potVal = 0;
%			end
%
%			potVals(i) = potVal;
%		end % end for i=1:numdata

		% subtract potential from data points near the new cluster center
		% Vectorized version by Roger Jang, 2-26-96
		new_sqshMultp = sqshMultp(ones(1,numPoints),:);
		tmp = maxPoint(ones(1,numPoints), :);
		dx = (tmp - X) .* new_sqshMultp;
		if numParams == 1,
			deduct = maxPotVal*exp(-4*dx.^2);
		else
			deduct = maxPotVal*exp(-4*sum(dx.^2,2));
		end
		potVals = potVals - deduct';
		potVals(potVals<0) = 0; 

		% find the data point with the highest remaining potential
		[maxPotVal,maxPotIndex] = max(potVals);

	elseif findMore == 2
		potVals(maxPotIndex) = 0;
		[maxPotVal,maxPotIndex] = max(potVals);
	end % end if findMore == 1
end % end while findMore & maxPotVal

% Scale the cluster centers from the normalized values back to values in
% the original range
for i=1:numParams
	centers(:,i) = (centers(:,i) * (maxX(i) - minX(i))) + minX(i);
end

% Compute the sigma values for the clusters
sigmas = (radii .* (maxX - minX)) / sqrt(8.0);

