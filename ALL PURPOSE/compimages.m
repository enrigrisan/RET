function compimages(v,fnext);
[pnv,fnv]=batchGUI;
n=length(pnv);
figure;
for ct=1:n,
   [x1,x2,x3,pn,fn]=loadimage(pnv{ct},fnv{ct});
   if v, 
      subplot(n,1,ct);
   else
      subplot(1,n,ct);
   end;
   imshow(nmlz(x1));
end;
saveas(gcf,[fnext,'.eps'],'eps');
saveas(gcf,[fnext,'.jpg'],'jpg');


   