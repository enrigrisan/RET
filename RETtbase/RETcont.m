function vc=RETcont(profilo,mvessel)
betav=0;
betanv=0;
tot1=0;
tot2=0;
if any(isnan(mvessel))
   vc=0;
   return
end

for i=1:length(profilo),
   betav=mvessel(i)*profilo(i)+betav;
   tot1=mvessel(i)+tot1;
   betanv=(1-mvessel(i))*profilo(i)+betanv;
   tot2=(1-mvessel(i))+tot2;
end

if betav|betanv,
   if tot1
      betav=betav/tot1;
   end
   
   if tot2
      betanv=betanv/tot2;
   end
   
   if betav>betanv
      massimo=betav;
   else
      massimo=betanv;
   end
   
   if tot1==0                 
      vc=0;
   elseif tot2==0
      vc=1;
   else
      vc=abs(betav-betanv)/massimo;
   end
else
   vc=0;
end;

