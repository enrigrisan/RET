
[xroi2,rroi,croi]=getroi(xroi,'Select area');
[r,c]=getpoints(xroi2,2,'Please insert calibre of reference outgoing vein');
coeff=sqrt((r(1)-r(2))^2+(c(1)-c(2))^2);