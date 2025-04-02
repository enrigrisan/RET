function imgout=paintcircle(imgin,centerx,centery,r,color)
centerx=int32(centerx);
centery=int32(centery);
imgout=imgin;
for x0=0:r
        y0=int32(floor(sqrt(double(r*r-x0*x0))));
		startx=centerx-x0;
		if startx<1 
			startx=1;
        end
		if startx>size(imgin,2) 
			startx=size(imgin,2);
        end

		endx=centerx+x0;
		if endx<1 
			endx=1;
        end
		if endx>size(imgin,2) 
			endx=size(imgin,2);
        end

		starty=centery-y0;
		if starty<1 
			starty=1;
        end
		if starty>size(imgin,1) 
			starty=size(imgin,1);
        end

		endy=centery+y0;
		if endy<1 
			endy=1;
        end
		if endy>size(imgin,1) 
			endy=size(imgin,1);
        end

		for i=starty:endy
		
			
            imgout(i,startx)=color;
            imgout(i,endx)=color;
        end
end
