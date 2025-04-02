
% roi :immagine in ingresso
% templ : template 
% roimask : maschera
% step : passo di ircerca
% xstart,ystart: cooordinate inizio ricerca
% roisizex,roisizey : dimensione roi di ricerca

function [imgcorr,xmax,ymax,corrmax]= RETODmatchcirc(roi,templ,roimask,step,xstart,ystart,roisizex,roisizey)

sizeroi=size(roi);
imgcorr=zeros(sizeroi);
height=sizeroi(1);
width=sizeroi(2);
corrmaxtmp=0;
if xstart <1
    xstart=1;
end
if ystart <1
    ystart=1;
end

xend=min(xstart+roisizex,width);
yend=min(ystart+roisizey,height);



for y=ystart:step:yend
    for x=xstart:step:xend
        corr=RETODcorr(roi,templ,roimask,x,y);
%         corr=RETODcorr2(roi,roimask,100,x,y);
        imgcorr(y,x)=corr;
        if corr>corrmaxtmp
            corrmaxtmp=corr;
            xmaxtmp=x;
			ymaxtmp=y;
        end
    end
end

corrmax=corrmaxtmp;
xmax=xmaxtmp;   
ymax=ymaxtmp;
    
