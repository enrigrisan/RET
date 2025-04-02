% RETzona function
% Finds the binary vector zones that have the given level 'level'
% Returns a matrix in which every row is a different zone, and the columns 
% represent the starting and finishing point, the mean zone diameter and the
% level (1 or 0) of the identified zone. ct is the last point analised in the vector
% dfthf
function [temp,acc_x,ct]=RETzona(dfthf,ct,level,d,t,temp,acc_x,dbf)

if dbf, disp('Inside RETzona'); end;

start=ct;
ct=ct+1;
while((dfthf(ct)==level)&(ct<length(dfthf))),  
   ct=ct+1;  
end;
finish=ct-1;

distanza=t(finish)-t(start);
if (distanza>0),  
   temp(acc_x,1)=start;
   temp(acc_x,2)=finish;
   temp(acc_x,3)=mean(d(temp(acc_x,1):temp(acc_x,2)));
   temp(acc_x,4)=level;  
   acc_x=acc_x+1;
end;

if dbf, disp('Finished RETzona'); end;
