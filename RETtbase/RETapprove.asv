function b=RETapprove(v,th,dmin,lnew,diamref,dbf);
if dbf, disp('>>> Inside RETapprove'); end;

vc=v>th;
lv=length(v);
b=any(lnew>=diamref/2);
ct=1;
while b&ct<=dmin,
    b=b&~vc(ct)&~vc(lv-ct+1);
    ct=ct+1;
end;

if dbf, disp('>>> Finished RETapprove'); end;
