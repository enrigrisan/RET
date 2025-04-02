%	-------------------------
%	- Function RETtort       -
%	-------------------------
%
% Update the input seg-structure adding for every segment a field t 
% with the tortuosity value
%
% k0   = scale factor
% lmin = minimum distance between two breaking points
%  h   = hysteresis threshold
% passo= resampling step ( the smaller the better)
%
% Suggested values:
%	k0=10 , lmin = 1 , h = .03:.08 , passo = .1
%
% Sintax:
%
%	y = RETtort(struttura SEG,k0,lmin,h,passo,flag debug)
%

function seg_out=RETtort(seg_in,tortpar,dbf)

if dbf, disp('Inside RETtort'); end;

k0=tortpar.k0;
lmin=tortpar.lmin;
h=tortpar.h;
passo=tortpar.passo;

seg_out=seg_in;

dim_seg = length(seg_in);

for ct= 1:1:dim_seg,
    if dbf      
        disp(['    Segment : ',num2str(ct)]);
    end;
    seg_out(ct).t = RETtort_seg(seg_in(ct).ppx,seg_in(ct).ppy,seg_in(ct).ppd,k0,lmin,h,passo,dbf);
end;

if dbf, disp('Finished RETtort'); end;
