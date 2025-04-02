%Put every angle as positive, and check for angles near 2pi and consider
%them as close to zero

function angle=RETgscheck2pi(angle_in,dbf)

if dbf, disp('Inside check2pi'); end;

angle=abs(angle_in);
if(angle>abs(angle-2*pi)),
   angle=angle-2*pi;
end;

if dbf, disp('Finished check2pi'); end;
