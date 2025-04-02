function ker=circker(r);

dimker=fix(2*r)+1;
ker=zeros(dimker);
center=r+1;

for ct1=1:dimker,
   for ct2=1:dimker,
      xcirc=ct1-center;
      ycirc=ct2-center;
      value=sqrt((xcirc)^2+(ycirc)^2);
      if (value<=r) ker(ct1,ct2)=1; end;
    end;
end;

ker=ker/sum(sum(ker));
