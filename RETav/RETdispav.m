

function RETdispav(xroi,seg)
figure;imshow(xroi);
hold on;
sseg=length(seg);
for ct=1:sseg,
   s=seg(ct);
   if(and(s.pav(1)>s.pav(2),s.pav(1)>s.pav(3))),
      r=0;
      b=1;
      %col=[s.pav(3),1-s.pav(2),s.pav(1)];
   elseif(and(s.pav(2)>s.pav(1),s.pav(2)>s.pav(3))),
      %col=[s.pav(3),1-s.pav(2),s.pav(1)];
      r=0;
      b=0;
   else,
      %col=[s.pav(3),1-s.pav(2),s.pav(1)];
      r=1;
      b=0;
   end;
   %plot(s.x,s.y,'Color',col);
   plot(s.x,s.y,'Color',[r,0,b]);
end;