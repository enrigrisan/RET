function z=freqpb2(x,lfx,hfx,lfy,hfy)

dimx=size(x);

ff=fft2(x);

cm=circmask2(dimx(1),dimx(2),lfx*dimx(1),hfx*dimx(1),lfy*dimx(2),hfy*dimx(2));

pbsff=fftshift(ff).*cm;
pbff=ifftshift(pbsff);
pb=ifft2(pbff);

z=real(pb);