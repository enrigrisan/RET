%  -----------------------------------
%  -    Fuction   RETseg_Spline        -
%  -----------------------------------
%
% It computes the PP-forms of the cubic smoothed spline approximating 
% the abscissa, the ordinates and the calibres of the barycenters, with 
% to the curvilinear coordinate
%
% Syntax:
% ---------
%
%	SEG out = RETseg_spline(SEG in,  smooth coef x-y, smooth coef d, flag debug);
%
% Parametri:
% ----------
%
%	smooth x-y = smoothing coefficient for the barycenter abscissa and ordinates
%	smooth d   = smoothing coefficient for calibres
%
% NB: Every element of the output stucture contains:
%
%  - x   : abscissa of new barycenters
%  - y   : ordinates of new barycenters
%  - d   : new diameters
%  - dir : direction from the barycenter
%  - ec  : exit conditions
%  - ppx : PP-form containing the information on the spline approximatin x(t)
%  - ppy : PP-form containing the information on the spline approximatin y(t)
%  - ppd : PP-form containing the information on the spline approximatin d(t)

% Constants :
% ----------
%
%	- distzero : In case many consecutive barycenters have diameter zero
%               only those distant more than distzero are considered
%

function str_out= RETseg_spline(str_in,smoothxy,smoothd,dbg);

if dbg disp('>> Inside RETseg_spline'); end;

dist_zero=100;

n_segmenti=length(str_in);

cont_RETseg_out=1;

for segmento=1:n_segmenti,
    
    if dbg
        disp(['running SEGMENT ',num2str(segmento)]);
    end;
    
    nx=str_in(segmento).x;
    ny=str_in(segmento).y;
    nd=str_in(segmento).d;
    ndir=str_in(segmento).dir;
    %ec=str_in(segmento).ec;
    
    dim_segmento=length(nx);
    
    nparam=RETparam(nx,ny,dbg);
    
    %controlla che non vi siano due punti consecutivi uguali
    x=[];
    y=[];
    d=[];
    dir=[];
    param=[];
    
    if(dim_segmento>2)
        ct2=1;
        for ct = 1:(dim_segmento-1),
            if ~(nparam(ct) == nparam(ct+1)),
                x(ct2)=nx(ct);
                y(ct2)=ny(ct);
                d(ct2)=nd(ct);
                dir(ct2)=ndir(ct);
                param(ct2)=nparam(ct);
                ct2=ct2+1;
            end;
        end;
        x(ct2)=nx(dim_segmento);
        y(ct2)=ny(dim_segmento);
        d(ct2)=nd(dim_segmento);
        dir(ct2)=ndir(dim_segmento);
        param(ct2)=nparam(dim_segmento);
        
        
        ppx = csaps(param,x,smoothxy);
        ppy = csaps(param,y,smoothxy);
        ppd = csaps(param,d,smoothd);
        
        if dbg
            disp([' Inserimento dati nella strutt. di uscita']);
        end;
        
        str_out(cont_RETseg_out).x=x';
        str_out(cont_RETseg_out).y=y';
        str_out(cont_RETseg_out).d=d';
        str_out(cont_RETseg_out).dir=dir';
        %str_out(cont_RETseg_out).ec=ec;
        
        %campi relativi alle ppforme
        str_out(cont_RETseg_out).ppx=ppx;
        str_out(cont_RETseg_out).ppy=ppy;
        str_out(cont_RETseg_out).ppd=ppd;
        
        cont_RETseg_out=cont_RETseg_out+1;
    else
%         str_out(cont_RETseg_out).x=[];
%         str_out(cont_RETseg_out).y=[];
%         str_out(cont_RETseg_out).d=[];
%         str_out(cont_RETseg_out).dir=[];
%         %str_out(cont_RETseg_out).ec=[];
%         
%         %campi relativi alle ppforme
%         str_out(cont_RETseg_out).ppx=[];
%         str_out(cont_RETseg_out).ppy=[];
%         str_out(cont_RETseg_out).ppd=[];
        
    end;
end;
    if dbg, disp('>> Finished RETseg_spline'); end;   

