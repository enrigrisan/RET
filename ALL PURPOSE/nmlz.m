function z=nmlz(x)
z=x;
z=z-min(min(z));
m=max(max(z));
if m,
    z=z/max(max(z));
end;
