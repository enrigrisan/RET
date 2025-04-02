function segnew=RETfix(xroi,seg,extpar,linkpar,splitpar,dbf);

if dbf, disp('Inside RETfix'); end;

segnew=seg;

if dbf, 
    RETdispseg(xroi,segnew,[0,1,0,1,1]); 
    title('Initial seg');
end;

ext=RETextrema(seg,extpar.npb,extpar.npd,dbf);

if dbf, 
    RETdispext(xroi,ext); 
    title('Extrema');
end;

segnew=RETsplit(segnew,ext,splitpar.minorder,splitpar.mindist,dbf);

if dbf, 
    RETdispseg(xroi,segnew,[0,1,0,1,1]); 
    title('After RETsplit');
end;

ext=RETextrema(segnew,extpar.npb,extpar.npd,dbf);

if dbf, 
    RETdispext(xroi,ext); 
    title('New Extrema');
end;

segnew=RETlink(segnew,ext,linkpar.dcoeff,linkpar.acoeff,linkpar.minscore,dbf);

if dbf, 
    RETdispseg(xroi,segnew,[0,1,0,1,1]); 
    title('After RETlink');
end;

if dbf, disp('Finished RETfix'); end;
