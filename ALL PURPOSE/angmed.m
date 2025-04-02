function am=andmed(a1,a2);
if a2>a1,
   atmp=a1;
   a1=a2;
   a2=atmp;
end;
adm=angdiff(a1,a2)/2;
if (a1-a2)<pi, 
   am=a2+adm;
else
   am=a1+adm;
end;
if am>pi, am=am-2*pi; end;
   
   
