% RETliminf
% given the matrix x, all the zero elements are substituted by a non-zero
% value, near to the computability lower bound

function y=RETliminf(x,dbf),

if dbf, disp('Inside RETliminf'); end

c=1e-10;
y=(x>=c).*x+(x<c)*c;

if dbf, disp('Exit RETliminf'); end
