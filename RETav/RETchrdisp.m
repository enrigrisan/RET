function RETchrdisp(x,y,p,img,dbf);

if dbf, disp('Inside RETchrdisp'); end;

figure;
imshow(img);
hold on;

n=length(x);
for ct=1:n,
    h=plot(fix(x(ct)),fix(y(ct)),'.');
    if p(ct,1),
        set(h,'Color',[0,0,1]);
    end;
    if p(ct,2),
        set(h,'Color',[0,1,0]);
    end;
    if p(ct,3),
        set(h,'Color',[1,0,0]);
    end;
end;

if dbf, disp('Finished RETchrdisp'); end;
    
        