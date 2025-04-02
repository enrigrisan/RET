function bft=RETfeat(xb,xc,xp,options,dbf)

%RETFEAT extracts blob features
%BFT = RETFEAT(XC,XP,OPTIONS,DBF) computes the features of the blob XB.
%   XB: binary image of dimensions [R1,C1] representing the blob.
%   XC: isoenlighted RGB blob image,of dimensions [R1,C1,3].
%   XP: blob posterior probability image determined by the initial MAP 
%   classificication, of dimensions [R1,C1].
%   OPTIONS: structure with fields: [WC, TYPE] 
%   WC is a parameter determining the border region 
%         TYPE is a flag indicating the tyoe of sign to be 
%         analysed: TYPE= 1 for white pathologic sign, TYPE=0
%				for dark ones
%   DBF debug flag.
%   Default value:  WC=0.5;
%
%   ADL 2001-03-19
%   EG  2001-05-21

if dbf, disp('Inside RETfeat'); end;

%non zero elements 
[r,c]=find(xb);
sxc=size(xc);
%vectorize image: instead of indexing with x(row,column), it will be
%indexed with x(ind)
rangeel=sxc(1)*(c-1)+r;


%colour statistics
xred=xc(:,:,1);
mred=mean(xred(rangeel));
sigmared=std(xred(rangeel));

xgreen=xc(:,:,2);
mgreen=mean(xgreen(rangeel));
sigmagreen=std(xgreen(rangeel));

xblue=xc(:,:,3);
mblue=mean(xblue(rangeel));
sigmablue=std(xblue(rangeel));

crg=RETcorr2(xred(rangeel),xgreen(rangeel),dbf);
crb=RETcorr2(xred(rangeel),xblue(rangeel),dbf);
cgb=RETcorr2(xgreen(rangeel),xblue(rangeel),dbf);


%probability statistics
valp=xp(rangeel);
mp=mean(valp);
sigmap=std(valp);

%area
area=length(r);

%border statistics
[rborder,cborder]=find(xb-double(imerode(xb,ones(3))));

%centroid, weighted by the probability image
pw=valp/sum(valp);
center=[sum(r.*pw);sum(c.*pw)];
[tmp,k]=min((r-center(1)).^2+(c-center(2)).^2);
center=[r(k);c(k)];

%radii
radii=sqrt((r-center(1)).^2+(c-center(2)).^2);
rb=sum(radii.*pw);
sigmarb=sqrt(sum(((radii-rb).^2).*pw));

%principal probability axis 
sxp=size(xp);
evt=REThotelling(r,c,pw,dbf);
      
a=0;
sta=1;           %step  
pt1=center;
pt2=pt1;
pt3=pt1;
pt4=pt1;
ecpt=zeros(1,4); 
fec=prod(ecpt);  %exit condition flag
while ~fec    
   if any((pt1(1)==rborder).*(pt1(2)==cborder))&~ecpt(1)
      a1=pt1;
   end
   if any((pt2(1)==rborder).*(pt2(2)==cborder))&~ecpt(2)
      a2=pt2;
   end
   if any((pt3(1)==rborder).*(pt3(2)==cborder))&~ecpt(3)
      b1=pt3;
   end
   if any((pt4(1)==rborder).*(pt4(2)==cborder))&~ecpt(4)
      b2=pt4;
   end
   a=a+sta; 
   pt1=round(a*evt(:,1)+center);
   ecpt(1)=~((pt1(1)<=sxp(1))&(pt1(1)>0)&(pt1(2)<=sxp(2))&(pt1(2)>0));
   pt2=round(-a*evt(:,1)+center);
   ecpt(2)=~((pt2(1)<=sxp(1))&(pt2(1)>0)&(pt2(2)<=sxp(2))&(pt2(2)>0));
   pt3=round(a*evt(:,2)+center);
   ecpt(3)=~((pt3(1)<=sxp(1))&(pt3(1)>0)&(pt3(2)<=sxp(2))&(pt3(2)>0));
   pt4=round(-a*evt(:,2)+center);
   ecpt(4)=~((pt4(1)<=sxp(1))&(pt4(1)>0)&(pt4(2)<=sxp(2))&(pt4(2)>0));
   fec=prod(ecpt);
   end
majpal=max(sqrt(sum((a1-a2).^2)),1);
minpal=max(sqrt(sum((b1-b2).^2)),1);


%compactness
sets=struct('r',1,'center',[],'dim',[]);
comp=length(find(xb-double(imerode(xb,RETcirck(sets,dbf)))))^2/area;


%excentricity
eccp=minpal/majpal;


%border statistics
rse=ceil(options.wc*sigmarb);
sets=struct('r',rse,'center',[],'dim',[]);

    %interior
in=find(double(imerode(xb,RETcirck(sets,dbf))));
if isempty(in)
   in=find(xb);
end

mpin=mean(xp(in));
sigmapin=std(xp(in));

sigmaredin=std(xred(in));
sigmagreenin=std(xgreen(in));
sigmabluein=std(xblue(in));

mredin=mean(xred(in));
mgreenin=mean(xgreen(in));
mbluein=mean(xblue(in));


   %internal side of the border
boundin=find(xb-double(imerode(xb,RETcirck(sets,dbf))));
mpboundin=mean(xp(boundin));
sigmapboundin=std(xp(boundin));

sigmaredboundin=std(xred(boundin));
sigmagreenboundin=std(xgreen(boundin));
sigmablueboundin=std(xblue(boundin));

mredboundin=mean(xred(boundin));
mgreenboundin=mean(xgreen(boundin));
mblueboundin=mean(xblue(boundin));

   %external side of the border
boundout=find(double(imdilate(xb,RETcirck(sets,dbf)))-xb);
mpboundout=mean(xp(boundout));
sigmapboundout=std(xp(boundout));

sigmaredboundout=std(xred(boundout));
sigmagreenboundout=std(xgreen(boundout));
sigmablueboundout=std(xblue(boundout));

mredboundout=mean(xred(boundout));
mgreenboundout=mean(xgreen(boundout));
mblueboundout=mean(xblue(boundout));

sigmared=RETliminf(sigmared,dbf);
sigmagreen=RETliminf(sigmagreen,dbf);
sigmablue=RETliminf(sigmablue,dbf);
sigmap=RETliminf(sigmap,dbf);
sigmapin=RETliminf(sigmapin,dbf);
sigmaredin=RETliminf(sigmaredin,dbf);
sigmagreenin=RETliminf(sigmagreenin,dbf);
sigmabluein=RETliminf(sigmabluein,dbf);
sigmapboundin=RETliminf(sigmapboundin,dbf);
sigmaredboundin=RETliminf(sigmaredboundin,dbf);
sigmagreenboundin=RETliminf(sigmagreenboundin,dbf);
sigmablueboundin=RETliminf(sigmablueboundin,dbf);
sigmapboundout=RETliminf(sigmapboundout,dbf);
sigmaredboundout=RETliminf(sigmaredboundout,dbf);
sigmagreenboundout=RETliminf(sigmagreenboundout,dbf);
sigmablueboundout=RETliminf(sigmablueboundout,dbf);

%Fisher ratio 
fpio=(mpboundin-mpboundout)^2/(sigmapboundin^2+sigmapboundout^2);
fpo=(mp-mpboundout)^2/(sigmap^2+sigmapboundout^2);
frio=(mredboundin-mredboundout)^2/(sigmaredboundin^2+sigmaredboundout^2);
fro=(mred-mredboundout)^2/(sigmared^2+sigmaredboundout^2);
fgio=(mgreenboundin-mgreenboundout)^2/(sigmagreenboundin^2+sigmagreenboundout^2);
fgo=(mgreen-mgreenboundout)^2/(sigmagreen^2+sigmagreenboundout^2);
fbio=(mblueboundin-mblueboundout)^2/(sigmablueboundin^2+sigmablueboundout^2);
fbo=(mblue-mblueboundout)^2/(sigmablue^2+sigmablueboundout^2);

if options.type
   bft=[mred,...  %1                              
         mgreen,...%2
         mblue,...%3
         mgreen/(mred+mgreen+mblue),...%5d
         mblue/(mred+mgreen+mblue),...%6d
         sigmared,...%7
         sigmagreen,...%8
         sigmablue,...%9
         sigmaredin,...%13
         sigmagreenin,...%14
         sigmabluein,...%15
         mredboundout,...%16
         mgreenboundout,...%17
         mblueboundout,...%18
         sigmaredboundout,...%19
         sigmagreenboundout,...%20d
         sigmablueboundout,...%21d
         fpo,...%28
         fro,...%30
         frio,...%31
         fgo,...%32
         fgio,...%33
         fbo,...%34
         fbio,...%35
         crg,...%36
         crb,...%37
         cgb,... %38
         mp,...%39
         sigmap,...%40
         mpin,...%41
         sigmapin,...%42
         mpboundout,...%43
         sigmapboundout,...%44
         mpboundin,....%45
         sigmapboundin,...%46
         area,...%47
         minpal,...%48
         majpal,...%49
         comp,...%52
         eccp];         
else bft=[mred,...  %1                              
         mgreen,...%2
         mblue,...%3
         mred/(mred+mgreen+mblue),...%4 
         sigmared,...%7
         sigmagreen,...%8
         sigmablue,...%9
         sigmaredin,...%13
         sigmagreenin,...%14
         sigmabluein,...%15
         mredboundout,...%16
         mgreenboundout,...%17
         mblueboundout,...%18
         sigmaredboundout,...%19
         sigmagreenboundin,...%26 
         fpo,...%28
         fro,...%30
         frio,...%31
         fgo,...%32
         fgio,...%33
         fbo,...%34
         fbio,...%35
         crg,...%36
         crb,...%37
         cgb,... %38
         mp,...%39
         sigmap,...%40
         mpin,...%41
         sigmapin,...%42
         mpboundout,...%43
         sigmapboundout,...%44
         mpboundin,....%45
         sigmapboundin,...%46
         area,...%47
         minpal,...%48
         majpal,...%49
         comp,...%52
         eccp];
end
if dbf, disp('Finished RETfeat'); end;




