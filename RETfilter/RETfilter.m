function segf=RETfilter(seg,parfilt,dbf);

fs=parfilt.fs;

sseg=length(seg);

segf=seg;

for ct=1:sseg,
    segf(ct).x=medfilt1(seg(ct).x,fs);
    segf(ct).y=medfilt1(seg(ct).y,fs);
    segf(ct).d=medfilt1(seg(ct).d,fs);
end;

    
    