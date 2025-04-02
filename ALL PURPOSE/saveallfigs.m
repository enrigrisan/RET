function saveallfigs(ids,tip);
ct=1;
gcf1=gcf;
while gcf1,
   saveas(gcf1,[ids,sprintf('%i',ct)],tip);
   close(gcf1);
   ct=ct+1;
   gcf1=gcf1-1;
end;
