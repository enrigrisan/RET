% ----------------
% - Function wgt -
% ----------------
%
% Sigmoid Function
% [a,b,c,d]=par;
% Computes the value of the sigmoid function described by
%
% y=c+d/(1+exp(-a(t-b)))
%
% for t=x
%
% Sintax:
%
%	y = wgt(x,a (slope),b (transl.),c (offset), d (end scale), debug flag)
%

% par: 1x4 vector
% x  : scalar
% dbf: boolean

function y = RETsigmoid(x,par,dbf)

if dbf, disp('>> Inside sigmoid'); end;

a=par(1);
b=par(2);
c=par(3);
d=par(4);

esp =-(a.*(x-b));
y = c+d./(1+exp(esp));

if dbf, disp('>> Finished sigmoid'); end;
