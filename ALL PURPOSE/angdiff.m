function ad=angdiff(a1,a2);
ad=abs(a1-a2);
ad=(ad>pi).*(2*pi-ad)+(ad<=pi).*ad;