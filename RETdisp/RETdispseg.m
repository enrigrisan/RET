%parameters:
% 1 - xr on baricenters
% 2 - -y on baricenters
% 3 - og on sides
% 4 - -b on sides

function RETdispseg(xroi,seg,pv,nlev)
if nargin<3,
    pv=ones(5,1);
end;
simshow(xroi);
hold on;
sseg=length(seg);
for ct=1:sseg,
    if (nargin<4)|((nargin==4))%&(seg(ct).o<=nlev)),
        s=seg(ct);
        if pv(1), plot(s.x,s.y,'xr'); end;
        if pv(2), h=plot(s.x,s.y,'-y'); end; %set(h,'Color',[0.99,1,1]);end;
        if pv(3),
            xp=[s.x+s.d/2.*cos(s.dir+pi/2);s.x-s.d/2.*cos(s.dir+pi/2)];
            yp=[s.y+s.d/2.*sin(s.dir+pi/2);s.y-s.d/2.*sin(s.dir+pi/2)];
            n=[1:5:length(xp)];
            %plot(s.x+s.d/2.*cos(s.dir+pi/2),s.y+s.d/2.*sin(s.dir+pi/2),'og');
            %plot(s.x-s.d/2.*cos(s.dir+pi/2),s.y-s.d/2.*sin(s.dir+pi/2),'og');
            for ctp=1:length(n)
                h=line(xp(:,n(ctp)),yp(:,n(ctp)));
                set(h,'Color','y','LineWidth',2);
            end;
        end;
        if pv(4), 
            plot(s.x+s.d/2.*cos(s.dir+pi/2),s.y+s.d/2.*sin(s.dir+pi/2),'-b');
            plot(s.x-s.d/2.*cos(s.dir+pi/2),s.y-s.d/2.*sin(s.dir+pi/2),'-b');
        end;
        if pv(5),
            h=text(s.x(1),s.y(1),num2str(ct));
            set(h,'Color',[0,1,1]);
            h=text(s.x(end),s.y(end),num2str(ct));
            set(h,'Color',[0,1,1]);
        end;
    end;
end;
