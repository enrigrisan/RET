function td=RETdispsegtort(xroi,seg)
if nargin<3,
    pv=ones(5,1);
end;
sims(xroi);
hold on;
sseg=length(seg);
for ct=1:sseg,
   s=seg(ct);
   h=plot(s.x,s.y,'x');
   set(h,'Color',[fsig(seg(ct).t,1,1),1-fsig(seg(ct).t,1,1),0]);
   sx=length(seg(ct).x);
   hsx=fix(sx/2);
   text(seg(ct).x(hsx),seg(ct).y(hsx),num2str(seg(ct).t,'%0.2f'));
   tv(ct,1)=seg(ct).t;
   tv(ct,2)=seg(ct).l;
end;
if nargout>0,
    td=tv;
end;
    
function y=fsig(x,p1,p2);
y=1/(1+exp(-p1*(x-p2)));