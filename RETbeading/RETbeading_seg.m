%	----------------------------
%	- Funzione RETbeading_seg -
%	----------------------------
%
% Return a m*2-dimensional matrix containing for
% every beading found its extreme barycenters
%
% Coeff. is the diameter of the greater vein at the OD
%
% Sintax:
%
%	beading = RETbeading_seg(t, d, l,nseg,bifcross, parameters, flag debug)
%
% ***************************************
%  Parameters
%
% th1   : Threshold for the creation of the binary vector dfth, as fraction
%				of the mean diameter.

% cth2   : Minimum difference between two adjacent zones, as fraction of
%				the mean diameter.
% cth3   : Minimum length of pathologic zone, as fraction of the mean diameter
% th4   : Maximum length of pathologic zone
% th5   : Minimum distance between two beading zones
% thl   : Length threshold 
% primo : First barycenter index
% idamax: threshold for the reliability prameter
%
% beading:[start,end,mean value,area,fan density]
%
% MM
% EG 2001-05-09
% EG 2001-06-20 Inserted thdfan thfan. Inserted comments. 
%               Analysis made excluding first two and last two barycenters


function beading=RETbeading_seg(t,d,l,nseg,bifcross,options,dbf)

dbfsub=0;
if dbf, disp('Inside RETbeading_seg'); end;

% Begin the analysis excluding the first two and last two barycenters, that are
% usualy very noisy (possibly close to bifurcations)
cutv=options.cutv;
d(1:cutv)=ones(cutv,1)*d(cutv+1);
d(length(d)-cutv+1:length(d))=ones(cutv,1)*d(length(d)-cutv);
%d=d(cutv+1:length(d)-cutv);
%t=t(cutv+1:length(t)-cutv);

th1=median(d);
th2=options.coefth2*th1;
th3=options.coefth3;
th4=options.th4;
th5=options.th5;
thdfan=options.thdfan;
thfan=options.thfan;
rnk=options.rnk;
thl=options.thl;
fin=options.fin;

df=RETrnkfilt(d,rnk,fin,dbfsub);

if dbf
    plot(t,d);
    hold on;
    %plot(t,df,'r');
end;

% If segment is longer than thl, the line resolving the least squares 
% problem is computed, for thresholding df, otherwise the constant 
% threshold th1 is used
intervallo=t;
per=0.3;
ini=t(length(t))*per;
fine=t(length(t))-t(length(t))*per;
ind=find(intervallo<ini|intervallo>fine);
if (l>thl),  
    p=polyfit(intervallo(ind),d(ind),1);  
    vth1=p(1)*intervallo+p(2);
else
    vth1(1:length(d),1)=th1;
end;

dfth=(df>5/6*vth1);

% Little isolated transitions are eliminated from vector dfth
dfthf=RETelimiaspikes(dfth,fin,dbfsub);

if dbf
    plot(intervallo,vth1,'m');
    %plot(t,dfth);
    plot(intervallo,5/6*vth1,'g');
    plot(intervallo,2/3*vth1,'k');
    %plot(t,dfthf,'r');
    hold off;
    pause
end;

ct=1;
temp=[];
acc_x=1;
intervallo=[];
beading=[];

% Classifies zones in the binary vector dfthf 
% temp is the matrix in which every row is a different zone acc_x, and the columns 
% represent the starting and finishing point, the mean zone diameter and the
% level (1 or 0) of the identified zone. ct is the last point analised in the vector
% dfthf
while (ct<length(dfthf)),
    switch(dfthf(ct)),
    case 0
        % finds a zones of subsequent zeros 
        [temp,acc_x,ct]=RETzona(dfthf,ct,0,d,t,temp,acc_x,dbfsub);
    case 1
        % finds a zones of subsequent ones          
        [temp,acc_x,ct]=RETzona(dfthf,ct,1,d,t,temp,acc_x,dbfsub);
    end;
end;

% Inserts in the beading matrix the zones recognised as beading
ct1=2;
acc1=1;
stemp=size(temp);

% Scan through the temp matrix
while(ct1<stemp(1)&stemp(1)>2),
    % Computes the entity of transition
    % For the given zone to be a beading, the transition
    % between the preceeding and following zones has to be
    % greater than the threshold th5
    down= t(temp(ct1-1,2))-t(temp(ct1-1,1));
    up=t(temp(ct1+1,2))-t(temp(ct1+1,1));
    cnd0=down>th5&up>th5;

    % The difference between the mean diameter of the given zone and
    % the preceeding and following zones has to be greater than the 
    % threshold th2
    cnd1=(abs(temp(ct1,3)-temp((ct1+1),3))>th2);
    cnd2=(abs(temp(ct1-1,3)-temp((ct1),3))>th2);
    
    % For the zone to be a beading zone, it has to be a 0 zone
    % and there must be some samples below 2/3 of the mean diameter
    cnd3=(temp(ct1,4)==0);
    cnd3=cnd3*any(d(temp(ct1,1):temp(ct1,2))<2/3*vth1(temp(ct1,1):temp(ct1,2)));
    
    % Computes the zone length
    % It has to be longer than th3 and shorter than th4
    lungh= t(temp(ct1,2))-t(temp(ct1,1));
    cnd4=(lungh> th3);
    cnd5=(lungh<th4);
    %disp([cnd0,cnd1,cnd2,cnd3,cnd4,cnd5])
    if ( cnd0 & and(cnd1,cnd2) & cnd3 & cnd4 & cnd5 ),
        % writes in the output matrix the extreme barycenters
        beading(acc1,1:3)=temp(ct1,1:3);
        
        % updates temp matrix with FAN values for the various zones 
        beading(acc1,1:8)=RETfan(t,df,beading(acc1,:),vth1,options,dbfsub);
        
        % Eliminates the zone if the fan density is smaller than thdfan and
        % the area is smaller than thfan
        if (beading(acc1,5)>thdfan)&(beading(acc1,4)>thfan),
            if dbf
                disp(beading);
            end;
            if beading,
                acc1 = acc1+1;
            end;
        else,
            beading(acc1,:)=[];
        end;
    end;
    ct1=ct1+1;      
end;

% Check for beading corresponding to a crossing
if (~isempty(bifcross))
    beading=RETchkbdbf(nseg,beading,bifcross,dbfsub);
end;

if dbf, disp('Ending RETbeading_seg'); end;