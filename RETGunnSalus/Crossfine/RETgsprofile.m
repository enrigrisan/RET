% RETprofile
% Performs the local tracking
% It gives on the output the coordinates of the points estimated as barycenter
% of the vessel
% RETprofile(xroif,v,step,mindis,dbf)
% xroif  : upsampled smoothed image of a small ROI about the estimated crossing
% v      : structures describing the segment
% step   : tracking step
% mindis : minimum distance from the end points before stopping
% dbf    : debug flag

function [x,y,err]=RETgsprofile(xroif,v,step,mindis,mintheta,minjmp,dbf);

if dbf, disp('Inside RETgprofile'); end;

if dbf,
    figure;
    imshow(xroif);
    hold on
end;

err=0;

%The resizing factor for xroif with respect to the original xroi is 10
rc=v.y(1)*10;
cc=v.x(1)*10;
rf=v.y(2)*10;
cf=v.x(2)*10;
x=cc;
y=rc;

if dbf,
    plot(cf,rf,'*y');
end;

diam=v.diam;
dire=v.dir(1,:);
thetaopt=angolo([cf-cc,rf-rc],dbf);
thetaopt=RETgscheck2pi(thetaopt,dbf);

sxroif=size(xroif);
ct=2;
rc(ct)=rc(1)+step*dire(2);
cc(ct)=cc(1)+step*dire(1);
x(ct)=cc(ct);
y(ct)=rc(ct);

%distance between the current (starting) point and the ending point
findis=sqrt((rc(ct)-rf)^2+(cc(ct)-cf)^2);

ec=0;
while ~ec
    %for the first two steps the direction dire is mantained
    if(ct<=2),
        theta=angolo(dire,dbf);
    else
        theta=angolo(dirnew,dbf);
    end;
    
    [r1,r2,c1,c2]=RETgscontrollabound(cc(ct),rc(ct),theta,diam,sxroif,dbf);
    prof=RETimprofile(xroif,[c1,c2],[r1,r2],dbf);
    
    [rcnew,ccnew,dirnew]=RETgsvalprofile(prof,cc,rc,theta,dbf);
    dis=sqrt((rc(ct)-rcnew)^2+(cc(ct)-ccnew)^2);
    alfa=angolo(dirnew,dbf);
    alfa=RETgscheck2pi(alfa,dbf);
    
    % If the local tracking arrives too close to the xroif boundaries, it is assumed
    % that a tracking error has occurred
    ec=(rcnew>sxroif(2)-10)|(rcnew<10)|(ccnew>sxroif(1)-10)|(ccnew<10);
    
    %If the new direction is too different from the optimal one,
    %or the new barycenter is too farther from the previous one
    %the optimal direction is kept, and an ideal update is made 
    if ~ec,
        if(abs(thetaopt-alfa)>mintheta|dis>minjmp),
            dirnew=dire;
            rc(ct)=rc(ct-1)+step*dire(2);
            cc(ct)=cc(ct-1)+step*dire(1);
            ct=ct+1;
            rc(ct)=rc(ct-1)+step*dire(2);
            cc(ct)=cc(ct-1)+step*dire(1);
            x(ct)=cc(ct);
            y(ct)=rc(ct);
            
            thetaopt=angolo([cf-cc(ct),rf-rc(ct)],dbf);
            thetaopt=RETgscheck2pi(thetaopt,dbf);
            dire=[cf-cc(ct),rf-rc(ct)]/sqrt((cf-cc(ct))^2+(rf-rc(ct))^2);
        else 
            ct=ct+1;
            x(ct)=ccnew;
            y(ct)=rcnew;
            rc(ct)=rcnew+step*dirnew(2);
            cc(ct)=ccnew+step*dirnew(1);
        end;
        
        %distance between the current point and the ending point
        findis=sqrt((rc(ct-1)-rf)^2+(cc(ct-1)-cf)^2);
        
        if dbf,
            plot([c1,c2],[r1,r2],'or');
            plot(cc(ct),rc(ct),'om');
            plot(ccnew,rcnew,'og')
            plot(cc(ct-1),rc(ct-1),'*b')
            pause(0.01)   
        end;
    end;
    
    ec=ec|~(findis>mindis);
end;

    
if dbf, disp('Exit RETgsprofile'); end;
    
    
    
    
    