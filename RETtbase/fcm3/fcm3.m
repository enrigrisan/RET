function [center, U, obj_fcn] = fcm3(data, cluster_n)

data_n = size(data, 1);
in_n = size(data, 2);

expo = 2;
max_iter = 100;		
min_impro = 1e-5;

obj_fcn = zeros(max_iter, 1);	% Array for objective function

U = initfcm3(cluster_n, data_n, data);			% Initial fuzzy partition

if any(data),
   for i = 1:max_iter,
      [U, center, obj_fcn(i)] = stepfcm3(data, U, cluster_n, expo);
      % check termination condition
      if i > 1,
         if abs(obj_fcn(i) - obj_fcn(i-1)) < min_impro, break; end,
      end
   end
   
   iter_n = i;	% Actual number of iterations 
   obj_fcn(iter_n+1:max_iter) = [];
else
   center=[zeros(1,size(data,2));mean(data)];
   obj_fcn=[];
end;

