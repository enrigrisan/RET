function seedsnew=RETbubseeds(x,xc,yc,ri,bn,bst,bth,vcmin,del,split,cfth,cmne,mincdist,mindistn,dbf);

if dbf, disp('>>> Inside RETBdecmat'); end;

[xsel,ysel,diamsel]=RETBdetect(x,xc,yc,ri,bn,bst,bth,vcmin,del,split,dbf);

if length(xsel)>=cmne,
    [xself,yself,diamself]=RETBfilter(xsel,ysel,diamsel,dbf);
    if length(xself)>cmne,
        [classvec,xclust,yclust]=RETBclust(xself,yself,xc,yc,cfth,dbf);
        if any(classvec),
            [classvec,xclust,yclust]=RETCclfix(classvec,xself,yself,xclust,yclust,mincdist,mindistn,cmne,dbf);
            if any(classvec),
                for ct=1:max(classvec),
                    ic=find(classvec==ct);
                    dirclust(ct)=vtorient2(yself(ic),xself(ic));
                    dclust(ct)=sum(diamself(ic))/length(ic);
                end;
                
%                 xclustcomp=[xclust;xclust;xclust;xclust;];
%                 yclustcomp=[yclust;yclust;yclust;yclust];
%                 dclustcomp=[dclust';dclust';dclust';dclust'];
%                 dirclustcomp=[dirclust';(dirclust'+pi);(dirclust+pi/2)';(dirclust'+3*pi/2)];
                
                xclustcomp=[xclust;xclust];
                yclustcomp=[yclust;yclust];
                dclustcomp=[dclust';dclust'];
                dirclustcomp=[dirclust';(dirclust'+pi)];

                seedsnew=RETseedstransform(xclustcomp,yclustcomp,dclustcomp,dirclustcomp,dbf);
            else
                seedsnew=[];
            end 
        else
            seedsnew=[];
        end;
    else
        seedsnew=[];
    end;
else
    seedsnew=[];
end;

if dbf, disp('>>> Finished RETBdecmat'); end;