function [xcv,ycv,dv,dirv,ec]=RETtrack(x,xini,yini,dirini,diamini,stini,th,dmin,vcmin,w1,w2,rdc,dbf)

if dbf, disp('>>> Inside RETtrack'); end;

tf=0;
sx=size(x);

% running point initialization
xatt=xini;
yatt=yini;
diamatt=diamini;
diratt=dirini;
psatt=diamini*2;
statt=stini;

% reference diameter initialization
diamref=diamini;

% initialization of results
xcv=xini;
ycv=yini;
dv=diamini;
dirv=dirini;

% boundary value for termination condition
bvalue=10;

if dbf, ct=0; end;

while ~tf,
  
   if dbf, 
      ct=ct+1;
      disp(sprintf('Tracking point %i = %i - %i',[ct,fix(xatt),fix(yatt)])); 
   end;
   
   %search for next profile
   [pchecked,xnew,ynew,lnew,vnew]=RETsprof(x,xatt,yatt,diratt,diamref,statt,psatt,th,dmin,vcmin,dbf);
   
   if pchecked,
      
      if (xnew<bvalue)|(xnew>sx(2)-bvalue)|(ynew<bvalue)|(ynew>sx(1)-bvalue),
         tf=1;
         ec=0; % out of frame
      else
         
         [xs,ys,ls,ndir,eci]=RETpick(xatt,yatt,diratt,diamref,xnew,ynew,lnew,w1,w2,rdc,dbf);
         
         if ~eci,
            % new point accepted
            xatt=xs;
            yatt=ys;
            diratt=angmed(ndir,diratt);
            diamatt=ls;
            diamref=(diamref+diamatt)/2;
            psatt=(psatt+1.5*diamatt)/2;
            xcv=[xcv,xatt];
            ycv=[ycv,yatt];
            dv=[dv,diamatt];
            dirv=[dirv,diratt];
         else
            % no new point accepted
            tf=1;
            ec=20+eci;
         end;
         
      end;
      
   else
      tf=1;
      ec=1; % no contrast
   end;
   
   if dbf,
      plot(xatt,yatt,'mo');
   end;
   
end;

if dbf,
   h=text(xatt+2,yatt+2,sprintf('%i',fix(ec)));
   set(h,'Color',[1,0.5,0]);
   set(h,'Fontweight','bold');
end;

if dbf, disp('>>> Finished RETtrack'); end;
   
   
   