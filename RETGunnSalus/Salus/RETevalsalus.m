% RETsalus
% Computes the index of the Salus sign

function [salusgrade]=RETevalsalus(segfix,cross,xc,yc,ct,ves1,ves2,dbf);

if dbf, disp('Inside RETsalus'); end;

[mdir1,mdir2]=RETmeandir(segfix,cross,xc,yc,ct,dbf);
[dirloc1,dirloc2]=RETdirloc(xc,yc,ves1,ves2,dbf);

if(all(mdir1~=-1)),
   %salusgrade(1)=min([abs(mod(mean(mdir1-dirloc1),pi)),abs(mod(mean(mdir1-dirloc1-pi),pi)),abs(mean(mdir1-dirloc1)),abs(mod(mean(mdir1-dirloc1+pi),pi))]);   
   d1=min(abs(angdiff(mdir1(1),dirloc1)),abs(angdiff(mdir1(1),dirloc1-pi)));
   d2=min(abs(angdiff(mdir1(2),dirloc1)),abs(angdiff(mdir1(2),dirloc1-pi)));
   salusgrade(1)=mean([d1,d2]);
else
   salusgrade(1)=-1;
end;

if(all(mdir2~=-1)),
   d1=min(abs(angdiff(mdir2(1),dirloc2)),abs(angdiff(mdir2(1),dirloc2-pi)));
   d2=min(abs(angdiff(mdir2(2),dirloc2)),abs(angdiff(mdir2(2),dirloc2-pi)));
   salusgrade(2)=mean([d1,d2]);
   %salusgrade(2)=min([abs(mod(mean(mdir2-dirloc2),pi)),abs(mod(mean(mdir2-dirloc2-pi),pi)),abs(mean(mdir2-dirloc2)),abs(mod(mean(mdir1-dirloc1+pi),pi))]);
else
   salusgrade(2)=-1;
end;

%salusgrade=mean(salusgrade1);

if dbf, disp('Exit RETsalus'); end;

