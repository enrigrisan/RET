function xbs=RETsmothblob(xb,options,dbf)

if  dbf, disp('Inside RETsmothblob'); end

se=options.se;
tharea=options.tharea;
sxb=size(xb);
xbs=zeros(sxb);

xbr=imdilate(imerode(xb,se),se);
xbf=imerode(imdilate(xbr,se),se);

%labelling the 8-connected components
label=bwlabel(xbf);
blobin=max(max(label));
strblobin=num2str(blobin);

if dbf, disp(['Blobs in: ',strblobin]), end
for ct1=1:blobin
   if dbf, disp([' Analyzing blob ',num2str(ct1),' of ',strblobin]); end
   [r,c]=find(label==ct1);
   ind=r+(c-1)*sxb(1);
   isbig=(length(ind)>tharea);
   xbs(ind)=isbig;
end
if dbf,
   blobout=max(max(bwlabel(xbs)));
   disp(['Blobs out: ',num2str(blobout)]);
   disp(['Blobs rejected: ',num2str(blobin-blobout)]);
   disp('Finished RETsmothblob')
end

   