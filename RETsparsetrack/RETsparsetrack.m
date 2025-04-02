function seg=RETsparsetrack(xroi,xs,ys,ds,nb,trackpar,lsegmin,doverlap,noverlap,dseed,dseedr,dbf),

if dbf, disp('Inside RETsparsetrack'); end;

stini=trackpar.stini;
th=trackpar.th;
dmin=trackpar.dmin;
vcmin=trackpar.vcmin;
bdc=trackpar.bdc;
rdc=trackpar.rdc;

seg=[];
segocc=[];
ct1=1;

dbfRETdiam=0;
dbfRETtrack=0;

fe=0;
while ~fe,
    sxs=length(xs);
    if sxs>1, 
        xs=xs(2:sxs);
        ys=ys(2:sxs);
        ds=ds(2:sxs);
        
        % to be substituted when a new RETdiam will be developed
        [diam,xc,yc,xl,yl,ec]=RETdiam2(xroi,xs(1),ys(1),nb,dbfRETdiam);
        if ec,
            d=atan2(yl(1)-yl(2),xl(1)-xl(2))+pi/2;
        end;
        % ------------------------------------------------------
        
        if dbf,
            disp(sprintf('%i seed points to go - RETdiam2 exit code : %i - ',[sxs,ec]));
        end;
        
        if ec,
            dsupp=d+pi;
            dsupp=(dsupp-2*pi)*(dsupp>pi)+dsupp*(dsupp<=pi);
            
            [xcv1,ycv1,dv1,dirv1,ec1]=RETtrack(xroi,xc,yc,d    ,diam,stini,th,dmin,vcmin,1,1,bdc,rdc,dbfRETtrack); 
            [xcv2,ycv2,dv2,dirv2,ec2]=RETtrack(xroi,xc,yc,dsupp,diam,stini,th,dmin,vcmin,1,1,bdc,rdc,dbfRETtrack);
            
            xcv1=xcv1';
            xcv2=xcv2';
            ycv1=ycv1';
            ycv2=ycv2';
            dv1=dv1';
            dv2=dv2';
            dirv1=dirv1';
            dirv2=dirv2';
            
            xcv=[xcv1(length(xcv1):-1:2);xcv2];
            ycv=[ycv1(length(xcv1):-1:2);ycv2];
            dv=[dv1(length(dv1):-1:2);dv2];
            dirv=[dirv1(length(dirv1):-1:2)+pi;dirv2];
            ec=[ec1,ec2];
            
            if length(xcv)>lsegmin,
                
%                 if dbf,
%                     sims(xroi);
%                     hold on;
%                     plot(xcv1,ycv1,'xg');
%                     plot(xcv2,ycv2,'xc');
%                     wmax(wgetname(gcf));
%                     ec
%                     pause;
%                     close;
%                 end;
                
                segn=RETcheckoverlap(seg,xcv,ycv,dirv,dv,ec,doverlap,noverlap,dbf);
                for ct2=1:length(segn),
                    xcv=segn(ct2).x;
                    ycv=segn(ct2).y;
                    dv=segn(ct2).d;
                    dirv=segn(ct2).dir;
                    ec=segn(ct2).ec;
                    if length(xcv)>lsegmin,
                        seg(ct1).x=xcv;
                        seg(ct1).y=ycv;	
                        seg(ct1).d=dv;
                        seg(ct1).dir=dirv;
                        seg(ct1).ec=ec;
                        ct1=ct1+1;
                        
                        [xs,ys,xe,ye]=RETcutseed4(xcv,ycv,xs,ys,dseed,dbf);
                        [xr,yr]=RETrecoverseed(xe,ye,xcv,ycv,dseedr,dbf);

                        if dbf,
                            disp(sprintf('RECOVERED %i seeds',length(xr)));
                        end;
                            
                        xs=[xr;xs];
                        ys=[yr;ys];
                    end;
                end;	
            end;
        end;
    else
        fe=1;
    end;
end;

if dbf, disp('Finished RETsparsetrack'); end;






