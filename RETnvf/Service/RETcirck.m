function ker=RETcirck(sets,dbf);

%RETcirck generates a circular kernel.
%   KER = RETcirk(R) generates a circular kernel of radius R. 
%   Kernel dimension is 2R+1.
%    
%   KER = RETcirck(R,CENTER,DIM) generates a circular kernel of 
%   radius and center CENTER in a matrix of dimension DIM
%
%   ADL 2001-02-09.
%	 EG 2001-04-27

if(dbf), disp('Inside RETcirck'); end;
r=round(sets.r);

if (isempty(sets.center))
   dimker=2*r+1*ones(1,2);
   ker=zeros(dimker);
   center=(r+1)*ones(1,2);
else
   dimker=sets.dim;
   ker=zeros(dimker);   
   center=sets.center;
end

for rcirc=[-r:r]
   for ccirc=[-r:r]
      value=sqrt(rcirc^2+ccirc^2);
      if value<=r 
         y=ccirc+center(2);
         x=rcirc+center(1);
         if (x>0)&(y>0)&(x<=dimker(1))&(y<=dimker(2))
            ker(x,y)=1;
         end
      end
      
   end
end

if(dbf), disp('Finished RETcirck'); end;