function evt=REThotelling(r,c,pw,dbf);
%RETHOTELLING computes the Hotelling transform.
%EVT = RETHOTELLING(R,C,PW) computes the direction of the image
%    principal axis. Each element of the image is identified by
%    row R, column C and statistic PW.
%    EVT is s bi dimensional square matrix, 
%    whose column are the vectors computed.
%
%    ADL 2001-03-19
%    EG  2001-05-21

if dbf, disp('Inside REThotelling'), end

rb=sum(r.*pw);
cb=sum(c.*pw);
s=zeros(2);
for ct1=1:length(r),
   x=[r(ct1);c(ct1)];
   s=s+x*x'*pw(ct1);
end;
k=s-[rb;cb]*[rb,cb];
[evt, evl]=eig(k);
if evl(1,1)<evl(2,2)
   evl=diag([evl(2,2),evl(1,1)]);
   evt=[evt(:,2),evt(:,1)];
end

if dbf, disp('Finished REThotelling'), end

