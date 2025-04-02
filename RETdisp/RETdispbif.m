function RETdispbif(xroi,segbif,bif,opt);

RETdispseg(xroi,segbif,opt);

for ct=1:length(bif);
    h=line([bif(ct).x(1),bif(ct).x(2)],[bif(ct).y(1),bif(ct).y(2)]);
    set(h,'Color',[0,1,0]);
    h=line([bif(ct).x(2),bif(ct).x(3)],[bif(ct).y(2),bif(ct).y(3)]);
    set(h,'Color',[0,1,0]);
    h=line([bif(ct).x(3),bif(ct).x(1)],[bif(ct).y(3),bif(ct).y(1)]);
    set(h,'Color',[0,1,0]);
end;

    
    