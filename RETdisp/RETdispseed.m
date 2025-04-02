function RETdispseed(xroi,seeds);
sims(xroi);
hold on;
[xs,ys,ds,dirs]=RETseedsextract(seeds,0);
h=plot(xs,ys,'o');
set(h,'Color',[0.99,1,1]);

for ct=1:length(seeds)
    plot(xs(ct)+ds(ct)*[cos(dirs(ct)+pi/2),cos(dirs(ct)-pi/2)],ys(ct)+ds(ct)*[sin(dirs(ct)+pi/2),sin(dirs(ct)-pi/2)],'r');
    h=text(xs(ct)+2,ys(ct)+2,num2str(ct));
end;
    
