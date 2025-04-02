function segmerge=RETmergeseg(seg1,seg2,doverlap,noverlap,lsegmin,dbf);

if dbf, disp('Inside RETmergeseg'); end;

sz1=length(seg1);
sz2=length(seg2);

segmerge=seg1;
ct1=length(segmerge)+1;

for ct=1:sz2,
    segn=RETcheckoverlap(seg1,seg2(ct).x,seg2(ct).y,seg2(ct).dir,seg2(ct).d,seg2(ct).ec,doverlap,noverlap,dbf);
    for ct2=1:length(segn),
        xcv=segn(ct2).x;
        ycv=segn(ct2).y;
        dv=segn(ct2).d;
        dirv=segn(ct2).dir;
        ec=segn(ct2).ec;
        if length(xcv)>lsegmin,
            segmerge(ct1).x=xcv;
            segmerge(ct1).y=ycv;	
            segmerge(ct1).d=dv;
            segmerge(ct1).dir=dirv;
            segmerge(ct1).ec=ec;          
            ct1=ct1+1;
        end;
    end;	
end;


if dbf, disp('Finished RETmergeseg'); end;
