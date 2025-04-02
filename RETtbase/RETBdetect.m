function [xsel,ysel,diamsel]=RETBdetect(x,xc,yc,ri,bn,bst,bth,vcmin,del,split,dbf)
if dbf, disp('>>> Inside RETBdetect'); end;

xsel=[];
ysel=[];
diamsel=[];

for ctb=1:bn,
   
   %[xtmp,ytmp,diamtmp]=RETBgetbub(x,xc,yc,ri+bst*ctb,bth,del,split,dbf);
   
   if split,
       splitn=fix(2*pi*(ri+bst*ctb)/split);
   else
       splitn=1;
   end;
   if ~splitn, splitn=1; end;

   if mod(ctb,7)==0
       dbfbub=1;
   else
       dbfbub=0;
   end;
   [xtmp,ytmp,diamtmp]=RETBgetbub(x,xc,yc,ri+bst*ctb,bth,vcmin,del,splitn,dbfbub*dbf);
   
   if length(xtmp),
      xsel=[xsel;xtmp];
      ysel=[ysel;ytmp];
      diamsel=[diamsel;diamtmp];
   end;
end;
   
if dbf, disp('>>> Finished RETBdetect'); end;

