%	----------------------------
%	- Function RETtrunk_pp -
%	----------------------------
%
% Computes the points in which the laplacian of the spline described
% through the input PP forms is zero. It gives as output the abscissa and ordinates
% of these events, the calibre at this points, the number of times it has
% happened
%
% Distanza = minimum distance between two breaking points
%
%
% Sintax:
%
%	[xzero,yzero,dzero,num. attrav.] = RETtrunk_pp(ppx,ppy,ppd,
%                                             distanza, h, passo, flag debug)
%

function [xzero,yzero,dzero,indici]=RETtrunk_pp(ppx,ppy,ppd,x,y,d,lmin,h,passo,dbf)

if dbf, disp('Inside RETtrunk_pp'); end;

sx=length(x);

t=RETparam(x,y,dbf);
k=RETk_pp(ppx,ppy,passo,dbf);
k=abs(k);

%inserisce il primo baricentro
ct2=1;
indici(ct2)=1;
bonex(ct2)=x(1);
boney(ct2)=y(1);
bonet(ct2)=t(1);
boned(ct2)=d(1);

%state for hyst cycle: 0, high, 1, low
state=0;
cindex=1;

for ct1=lmin:sx-lmin,
    
    switch state
    case 0,
        switch k(ct1)<h,
        case 1
            state=1;
            cindex=ct1;
        end;
    case 1,
        switch k(ct1)>h,
        case 1,
            ni=fix((cindex+ct1)/2);
            
            l_x=x(indici(ct2):ni);
            l_y=y(indici(ct2):ni);
            
            l=RETl(l_x,l_y,1,dbf);
            
            %breaks only if new subsegment is long enough
            if l>lmin
                ct2=ct2+1;
                indici(ct2)=ni;
                bonex(ct2)=x(ni);
                boney(ct2)=y(ni);
                bonet(ct2)=t(ni);
                boned(ct2)=d(ni);
                state=0;
            end;
        end;
    end;
end;

%last point insertion
ni=sx;
l_x=x(indici(ct2):ni);
l_y=y(indici(ct2):ni);

l=RETl(l_x,l_y,1,dbf);

%breaks only if new subsegment is long enough
if l>lmin
    ct2=ct2+1;
    indici(ct2)=ni;
    bonex(ct2)=x(ni);
    boney(ct2)=y(ni);
    bonet(ct2)=t(ni);
    boned(ct2)=d(ni);
else
    indici(ct2)=ni;
    bonex(ct2)=x(ni);
    boney(ct2)=y(ni);
    bonet(ct2)=t(ni);
    boned(ct2)=d(ni);
end;


xzero=bonex;
yzero=boney;
dzero=boned;

if dbf, disp('Finished RETtrunk_pp'); end;
