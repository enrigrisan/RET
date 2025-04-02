function z=freqpb(x,lf,hf)

dimx=size(x);

ff=fft2(x);

cm=circmask2(dimx(1),dimx(2),lf*dimx(1),hf*dimx(1),lf*dimx(2),hf*dimx(2));


pbsff=fftshift(ff).*cm;
pbff=ifftshift(pbsff);
pb=ifft2(pbff);

z=real(pb);