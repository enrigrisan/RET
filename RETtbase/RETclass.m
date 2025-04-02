function v=RETclass(p,ps,dbf);

if dbf, disp('>>> Inside RETclass'); end;

lp=length(p);

nsp=(lp/(ps/2))-1;

for cts=1:nsp,
   ptmp=p(1+ps/2*(cts-1):ps+ps/2*(cts-1));
   %ptmp=ptmp-min(min(ptmp));
   %mptmp=max(max(ptmp));
   %if mptmp,
   %   ptmp=ptmp/max(max(ptmp));
   %end;
   sp(cts,:)=ptmp;
end

%%% to be checked
for cts=1:nsp,
   [ctr,u,obj]=fcm2(sp(cts,:)',2);
   [minimo,pz]=min(ctr);
   uf(cts,:)=u(pz,:);
end
%%% to be checked

v=zeros(1,lp);
for cts=1:nsp,																	
   v((cts-1)*ps/2+1:(cts-1)*ps/2+ps)=v((cts-1)*ps/2+1:(cts-1)*ps/2+ps)+uf(cts,:);
end
v(fix(ps/2+1):fix(lp-ps/2))=v(fix(ps/2+1):fix(lp-ps/2))/2;
v=v.*~isnan(v);

%f=ones(1,5)/5;
%v=conv(v,f);
%v=v(3:length(v)-2);

% if dbf,
%     h=gcf;
%     figure;
%     plot(p,'x');
%     hold on;
%     plot(v,'og');
%     figure(h);
% end;
    
if dbf, disp('>>> Finished RETclass'); end;
