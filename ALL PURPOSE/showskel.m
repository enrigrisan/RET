function showskel(xo,xs);
xtmp=double(~xs).*xo+double(xs)*max(max(xo));
sims(xtmp);