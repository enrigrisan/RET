function seeds=RETseed(xroi,ngrid,vth,nmin,dmin,glfilt,dlims,nsd1,nsd2,xod,yod,rod,dbf)

if dbf, disp('Inside RETseed'); end;

[seeds,th]=RETthreshold(xroi,ngrid,vth,nmin,dbf);

seeds=RETmaskseeds(xroi,seeds,dbf);

seeds1=seeds;

seeds=RETcutseedod(seeds,xod,yod,rod,dbf);

seeds2=seeds;

seeds=RETcutseed3(seeds,xroi,nsd1,dbf);

seeds3=seeds;

if(length(seeds)<4000)
    seeds=RETcutseed1(seeds,dmin,xroi,glfilt,dbf);

    seeds4=seeds;

    seeds=RETcutseed2(seeds,dlims,dbf);

    seeds5=seeds;

    seeds=RETcutseed3(seeds,xroi,nsd2,dbf);

    seeds6=seeds;

    if dbf,
        disp(sprintf('Number of seeds 1 : %f',length(seeds1)));
        disp(sprintf('Number of seeds 2 : %f',length(seeds2)));
        disp(sprintf('Number of seeds 3 : %f',length(seeds3)));
        disp(sprintf('Number of seeds 4 : %f',length(seeds4)));
        disp(sprintf('Number of seeds 5 : %f',length(seeds5)));
        disp(sprintf('Number of seeds 6 : %f',length(seeds6)));

        [x,y,d,dir]=RETseedsextract(seeds1,dbf);
        sims(xroi);
        hold on;
        plot(x,y,'og');
        %plot(x+d*[cos(dir+pi/2),cos(dir-pi/2)],y+d*[sin(dir+pi/2),sin(dir-pi/2)],'r');
        title('s1');

        [x,y,d,dir]=RETseedsextract(seeds2,dbf);
        sims(xroi);
        hold on;
        plot(x,y,'og');
        %plot(x+d*[cos(dir+pi/2),cos(dir-pi/2)],y+d*[sin(dir+pi/2),sin(dir-pi/2)],'r');
        title('s2');

        [x,y,d,dir]=RETseedsextract(seeds3,dbf);
        sims(xroi);
        hold on;
        plot(x,y,'og');
        %plot(x+d*[cos(dir+pi/2),cos(dir-pi/2)],y+d*[sin(dir+pi/2),sin(dir-pi/2)],'r');
        title('s3');

        [x,y,d,dir]=RETseedsextract(seeds4,dbf);
        sims(xroi);
        hold on;
        plot(x,y,'og');
        %plot(x+d*[cos(dir+pi/2),cos(dir-pi/2)],y+d*[sin(dir+pi/2),sin(dir-pi/2)],'r');
        title('s4');

        [x,y,d,dir]=RETseedsextract(seeds5,dbf);
        sims(xroi);
        hold on;
        plot(x,y,'og');
        %plot(x+d*[cos(dir+pi/2),cos(dir-pi/2)],y+d*[sin(dir+pi/2),sin(dir-pi/2)],'r');
        title('s5');

        [x,y,d,dir]=RETseedsextract(seeds6,dbf);
        sims(xroi);
        hold on;
        plot(x,y,'og');
        %plot(x+d*[cos(dir+pi/2),cos(dir-pi/2)],y+d*[sin(dir+pi/2),sin(dir-pi/2)],'r');
        title('s6');
    end;
end;
if dbf, disp('Finished RETseed'); end;

