function DisplayDarkData2(a,image,n1,n2);

segni=[
    '+',
    'v',
    '*',
    'x',
    'd',
    'o'
];
i=1;

for j=1:60,
    nhae=find(a(:,1)==1&image'==j);
    nfp=find(a(:,1)~=1&image'==j);
    if(~isempty(nhae))
        h=plot(a(nhae,n1),a(nhae,n2),segni(i));
        set(h,'Color',[1,0,0]);
        h=plot(a(nfp,n1),a(nfp,n2),segni(i));
        i=i+1;
    else,
        h=plot(a(nfp,n1),a(nfp,n2),'.');
        set(h,'Color',[0,0,255/60*j]);
    end;
end;
