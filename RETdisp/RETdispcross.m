% options
% 1 - 

function RETdispcross(xroi,seg,cross,pv);

if pv(1),
    RETdispseg(xroi,seg,[0,1,0,1,1]);
    hold on;
else
    sims(xroi);
    hold on;
end;

for ct=1:length(cross);
    if ~pv(1),
        plot(seg(cross(ct).s1).x,seg(cross(ct).s1).y);
        plot(seg(cross(ct).s2).x,seg(cross(ct).s2).y);
    end;
    plot(cross(ct).x,cross(ct).y,'xr');
end;

        

