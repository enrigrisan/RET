%	--------------------------
%	-Function RETview-
%	--------------------------
%
% Visualize spline approximation of tracked barycenter 
%
% 
% Sintax:
%	
% ret_view(structure SEG,image_name, debug flag)
%

function RETdispspline(xroi,seg,pv)

passo=.1;

dim_struttura  = length(seg);

sims(xroi);
hold on;

for cont = 1:dim_struttura,
    x = fnval(seg(cont).ppx,[seg(cont).ppx.breaks(1):passo:seg(cont).ppx.breaks(length(seg(cont).ppx.breaks))]);
    y = fnval(seg(cont).ppy,[seg(cont).ppy.breaks(1):passo:seg(cont).ppy.breaks(length(seg(cont).ppy.breaks))]);
    d = fnval(seg(cont).ppd,[seg(cont).ppd.breaks(1):passo:seg(cont).ppd.breaks(length(seg(cont).ppd.breaks))])/2;
    
    dist    = sqrt((x(2:length(x))-x(1:length(x)-1)).^2+(y(2:length(y))-y(1:length(y)-1)).^2);
    sin_ang = (y(2:length(y))-y(1:length(y)-1))./dist;
    sin_ang = [sin_ang(1) sin_ang];
    cos_ang = (x(2:length(x))-x(1:length(x)-1))./dist;
    cos_ang = [cos_ang(1) cos_ang];
    
    plot(x, y, 'g');
    plot(x-d.*sin_ang,y+d.*cos_ang,'r');
    plot(x+d.*sin_ang,y-d.*cos_ang,'r');
    
    if pv(1),
        stringa = num2str(cont);
        text(x(1,1)-3,y(1,1)-3,stringa,'FontSize',8,'Color','cyan');   
    end;
    if pv(2),
        plot(seg(cont).x,seg(cont).y,'xc');
    end;
    if pv(3),
        plot(seg(cont).x+seg(cont).d/2.*cos(seg(cont).dir+pi/2),seg(cont).y+seg(cont).d/2.*sin(seg(cont).dir+pi/2));
        plot(seg(cont).x-seg(cont).d/2.*cos(seg(cont).dir+pi/2),seg(cont).y-seg(cont).d/2.*sin(seg(cont).dir+pi/2));
    end;
    
end;

set(gca,'Ydir','reverse');



