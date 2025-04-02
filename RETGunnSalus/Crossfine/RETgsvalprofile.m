% RETvalprofile
% Given the gray scale perperndicular slice of the vessel prof,
% it returns the point of minimum, corresponding to the vessel center,
% and the new directions

function [rcnew,ccnew,dirnew]=RETgsvalprofile(prof,c,r,theta,dbf);

if dbf, disp('Inside RETvalprofile'); end;

sr=length(r);
profs=fnval(csaps([1:length(prof)],prof,0.01),[1:0.1:length(prof)]);
proff=fnval(fnder(csaps([1:length(prof)],prof,0.01),1),[1:length(prof)]);
n=find(proff==0);

if length(n)==3,
   m=0.5*(n(3)-n(1));
elseif length(n)==1,
   m=fix(find(profs==min(profs))/10);
else
   mt=find(profs==min(profs));
   m=fix(mean(mt)/10);
end;

diffc=m-length(prof)/2;
rcnew=[r(sr)+diffc*sin(theta+pi/2)];
ccnew=[c(sr)+diffc*cos(theta+pi/2)];

ind=max(1,sr-5);
dirnew=[ccnew-mean(c(ind:sr-1)),rcnew-mean(r(ind:sr-1))]/sqrt((rcnew-mean(r(ind:sr-1)))^2+(ccnew-mean(c(ind:sr-1)))^2);

if dbf, disp('Exit RETvalprofile'); end;
