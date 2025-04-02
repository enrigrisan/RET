%	---------------------------
%	- Function RETtort_seg   -
%	---------------------------
%
% Computes the tortuosity measure for the input segment described by the
% PP forms ppx ppy ppd
%
% k0   = scale factor
% lmin = minimum distance between two breaking points
%  h   = hysteresis threshold
% passo= resampling step ( the smaller the better)
%
%
% Sintax:
%
%	y = RETtort_seg(ppx, ppy, ppd, k0, lmin, hysteresis thereshold,flag debug)
%

function tort = RETtort_seg(ppx,ppy,ppd,k0,lmin,h,passo,dbf)

if dbf, disp('Inside RETtort_seg'); end;

x=fnval(ppx,[ppx.breaks(1):passo:ppx.breaks(length(ppx.breaks))]);
y=fnval(ppy,[ppy.breaks(1):passo:ppy.breaks(length(ppy.breaks))]);
d=fnval(ppd,[ppd.breaks(1):passo:ppd.breaks(length(ppd.breaks))]);

[xz,yz,dz,k,indici]=RETtrunk_pp(ppx,ppy,ppd,x,y,d,lmin,h,passo,dbf);

% calcola il vettore lunghezza delle corde 
n=length(xz);
l_chord = sqrt((xz(2:n)-xz(1:n-1)).^2+(yz(2:n)-yz(1:n-1)).^2);

for i = 1:n-1,
    nx=x(indici(i):indici(i+1));
    ny=y(indici(i):indici(i+1));
    mr(i)=std(k(indici(i):indici(i+1)));
    % calcola il vettore delle lunghezze degli spezzoni
    li(i)=RETl(nx,ny,1,dbf);
end;

% calcola il vettore di tortuosita' del segmento  
for i = 1:length(li),
    term0(i) = k0*((li(i)/l_chord(i))-1);  
end;

% valore di tortuosita' del segmento
tort=sum(term0);

if dbf, disp('Finished RETtort_seg'); end;
