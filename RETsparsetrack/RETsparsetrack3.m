function seg=RETsparsetrack3(xroi,seeds,rdpar,trackpar,bubpar,stpar,dbf);

if dbf, disp('Inside RETsparsetrack'); end;

%tracking parameters
stini=trackpar.stini;
th=trackpar.th;
dmin=trackpar.dmin;
vcmin=trackpar.vcmin;
rdc=trackpar.rdc;

%bubble continue parameters
nb2=bubpar.nb;
ri=bubpar.ri;
bst=bubpar.bst;
bth=bubpar.th;
del=bubpar.del;
split=bubpar.split;
cfth=bubpar.cfth;
cmne=bubpar.cmne;
mincdist=bubpar.mincdist;
mindistn=bubpar.mindistn;

%sparse trackign parameters
lsegmin=stpar.lsegmin;
doverlap=stpar.doverlap;
noverlap=stpar.noverlap;
dseed=stpar.dseed;
dseedr=stpar.dseedr;

%initialisation of main struture and main counter
seg=[];
ct1=1;

%internal debug flug initialisation
dbfRETdiam=0;
dbfRETtrack=0;
dbfRETbubseeds=0;

%on line display of tracked portions
if dbf,
    RETdispseed(xroi,seeds);
end;

%exit flag
fe=0;

while ~fe,
    
    sseeds=length(seeds);
    
    if sseeds>0, 
        if seeds(1).dir==99,
            [diam,xc,yc,xl,yl,ec]=RETdiam2(xroi,seeds(1).x,seeds(1).y,rdpar,dbfRETdiam);
            if ec,
                d=atan2(yl(1)-yl(2),xl(1)-xl(2))+pi/2;
            end;
        else
            xc=seeds(1).x;
            yc=seeds(1).y;
            diam=seeds(1).d;
            d=seeds(1).dir;
            ec=100;
        end;
        
        if dbf,
            %display of processed seed point
            seedx=seeds(1).x;
            seedy=seeds(1).y;
            plot(seedx,seedy,'xr');
            if ~ec, text(seeds(1).x,seeds(1).y,'RDF'); end;
        end;

        seeds=seeds(2:sseeds);
        
        disp(sprintf('%i seed points to go - RETdiam2 exit code : %i - ',[sseeds,ec]));
        
        if ec,
            dsupp=d+pi;
            dsupp=(dsupp-2*pi)*(dsupp>pi)+dsupp*(dsupp<=pi);
            w1=0.5;
            w2=0.5;
            [xcv1,ycv1,dv1,dirv1,ec1]=RETtrack(xroi,xc,yc,d    ,diam,stini,th,dmin,vcmin,w1,w2,rdc,dbfRETtrack); 
            [xcv2,ycv2,dv2,dirv2,ec2]=RETtrack(xroi,xc,yc,dsupp,diam,stini,th,dmin,vcmin,w1,w2,rdc,dbfRETtrack);
            
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
            
            if dbf, text(seedx,seedy,[num2str(ec1),'-',num2str(ec1)]); end;
            
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
                        
                        %on line display of tracked portions
                        if dbf,
                            plot(xcv,ycv,'xc');
                        end;
                           
                        %continue seed extraction
                        sxcv=length(xcv);
                        %dbfRETbubseeds=1;
                        seedsnew1=RETbubseeds(xroi,xcv(1)+ri*cos(dirv(1)+pi),ycv(1)+ri*sin(dirv(1)+pi),ri,nb2,bst,bth,vcmin,del,split,cfth,cmne,mincdist,mindistn,dbfRETbubseeds);
                        seedsnew2=RETbubseeds(xroi,xcv(sxcv)+ri*cos(dirv(sxcv)),ycv(sxcv)+ri*sin(dirv(sxcv)),ri,nb2,bst,bth,vcmin,del,split,cfth,cmne,mincdist,mindistn,dbfRETbubseeds);
                        seeds=[seedsnew1,seedsnew2,seeds];
                        %dbfRETbubseeds=0;
                        
                        if dbf,
                            plot(xcv(1)+ri*cos(dirv(1)+pi),ycv(1)+ri*sin(dirv(1)+pi),'db');
                            for ctdbf1=1:length(seedsnew1),
                                plot(seedsnew1(ctdbf1).x,seedsnew1(ctdbf1).y,'*b');
                                h=line([seedsnew1(ctdbf1).x,seedsnew1(ctdbf1).x+10*cos(seedsnew1(ctdbf1).dir)],[seedsnew1(ctdbf1).y,seedsnew1(ctdbf1).y+10*sin(seedsnew1(ctdbf1).dir)]);
                                set(h,'Color',[0,1,0]);
                            end;
                            plot(xcv(sxcv)+ri*cos(dirv(sxcv)),ycv(sxcv)+ri*sin(dirv(sxcv)),'db');
                            for ctdbf1=1:length(seedsnew2),
                                plot(seedsnew2(ctdbf1).x,seedsnew2(ctdbf1).y,'*b');
                                h=line([seedsnew2(ctdbf1).x,seedsnew2(ctdbf1).x+10*cos(seedsnew2(ctdbf1).dir)],[seedsnew2(ctdbf1).y,seedsnew2(ctdbf1).y+10*sin(seedsnew2(ctdbf1).dir)]);
                                set(h,'Color',[1,0,0]);
                            end;
                            pause(1e-6);
                        end;
                        
                        %removal and recovery of seed points
                        [seeds,seedse]=RETcutseed4(seg,seeds,dseed,dbf);
                        if length(seedse),
                            seedsr=RETrecoverseed(seedse,seg,dseedr,dbf);
                        else
                            seedsr=[];
                        end;
                        
                        if dbf,
                            disp(sprintf('ADDED     %i seeds',length([seedsnew1,seedsnew2])));
                            disp(sprintf('DELETED   %i seeds',length(seedse)));
                            disp(sprintf('RECOVERED %i seeds',length(seedsr)));
                        end;
                        
                        seeds=[seedsr,seeds];
                    end;
                end;	
            end;
        end;
    else
        fe=1;
    end;
end;

if dbf, disp('Finished RETsparsetrack'); end;






