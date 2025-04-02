function [x,y,c,xyz,lab]=RETchromo(seg,img,kerdim,dbf);

if dbf, disp('Inside RETchromo'); end;

gk=circker(kerdim);

imgf(:,:,1)=conv2(img(:,:,1),gk,'same');
imgf(:,:,2)=conv2(img(:,:,2),gk,'same');
imgf(:,:,3)=conv2(img(:,:,3),gk,'same');

x=[];
y=[];
c=[];
xyz=[];
lab=[];

n=length(seg);
for ct=1:n,
    x=[x;seg(ct).x];
    y=[y;seg(ct).y];
    np=length(seg(ct).x);
    for ct2=1:np,
        yp=fix(seg(ct).y(ct2));
        xp=fix(seg(ct).x(ct2));
        c=[c;imgf(yp,xp,1),imgf(yp,xp,2),imgf(yp,xp,3)];
        xyz=[0.607*c(:,1)+0.174*c(:,2)+0.2*c(:,3),0.299*c(:,1)+0.587*c(:,2)+0.114*c(:,3),0.066*c(:,2)+1.116*c(:,3)];
        lab=[116*((xyz(:,2)).^(1/3))-16,500*((xyz(:,1)).^(1/3)-(xyz(:,2)).^(1/3)),200*((xyz(:,2)).^(1/3)-(xyz(:,3)).^(1/3))];
    end;
end;

if dbf, disp('Finished RETchromo'); end;
