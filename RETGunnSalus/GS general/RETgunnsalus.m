function [gunngrade,salusgrade]=RETgunnsalus(xroi,seg,cross,scale,optionsini,optionscross,optionsgunn,dbf)

if dbf, disp('Inside RETgunnsalus'); end;

seggs=seg;
gunngrade=[];
salusgrade=[];

for ct=1:length(cross),
    if dbf, 
        disp(['GS: processintg crossing', num2str(ct), 'of',num2str(length(cross))]); 
    end;
    
    [xroif,v1,v2,dimroi,err]=RETgsinitialize(xroi,seg,cross(ct),optionsini,dbf);
    
    %WORKING ON ROI - BEGIN -
    if ~err,
        [xc,yc,ves1,ves2,err]=RETgscrossfine(xroif,v1,v2,optionscross,dbf);
    end;
    
    if ~err,
        [d,diam,dis,der,err]=RETfindgunn(xroif,xc,yc,v1,v2,optionsgunn,dbf);
    end;
    
    if ~err,
       [gunngrade(ct,:),diam]=RETevalgunn(d,ves1,ves2,v1,v2,scale,dbf);
    else,
       gunngrade(ct,:)=[-1000,-1000];
       diam=0;
    end;
    
    if ~err,
        [xco,yco]=RETgsorimcoord(xc,yc,dimroi,cross(ct).x,cross(ct).y,dbf);
    end;
    %WORKING ON ROI - END -
    
    if ~err,
       salusgrade(ct,:)=RETevalsalus(seg,cross,xco,yco,ct,ves1,ves2,dbf);
    else,
       salusgrade(ct,:)=[-1,-1];
    end;
end;


if dbf, disp('Finished RETgunnsalus'); end;
