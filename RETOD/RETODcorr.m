function corr=RETODcorr(roi,templ,roimask,x,y)

sizeroi=size(roi);
height=sizeroi(1);
width=sizeroi(2);

sizetempl=size(templ,1);% template quadrato con lato lunghezza dispari
s=(sizetempl-1)/2;
val=0;
n=0;


for yk=-s:s
    for xk=-s:s
            if y+yk >0 && x+xk>0 && y+yk<=height && x+xk <= width
                if roimask(y+yk,x+xk) && templ(s+yk+1,s+xk+1);
                    val=val+templ(s+yk+1,s+xk+1)*roi(y+yk,x+xk);
                    n=n+1;
                end
            end
    end
end
if n==0
    corr=0;
else
    corr=val/n;
end

    
    
                
        

