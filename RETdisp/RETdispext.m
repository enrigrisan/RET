function RETdispext(xroi,ext);
ds=5;

sims(xroi);
hold on;
sext=length(ext);
for ct=1:sext,
   e=ext(ct);
   plot(e.xe,e.ye,'xr');
   plot(e.xb,e.yb,'og');
   %h=arrow([e.xb-ds*cos(e.dir),e.yb-ds*sin(e.dir)],[e.xb+ds*cos(e.dir),e.yb+ds*sin(e.dir)]);
   %arrow(h,'Length',ds/4,'Tipangle',15,'Width',0.1);
   h2=text(e.xe,e.ye,num2str(ct));
   set(h2,'Color',[0,1,0]);
end;    