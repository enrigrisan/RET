function output = AviRead(filename,option,option2,option3)

%-------------------------------------------------------------------------
% result = AviRead (filename, 
%                   number of frames to process, 
%                   first frame to display, 
%                   last frame to display)
%
% Example: AviRead('sample.avi',30,10,12)
%            reads and processes the first 30 frames of the file 
%            'sample.avi', and displays frame 10, 11 and 12 each 
%            in its own figure.       
%
% Reads AVI-files and processes position of pixel maximum per frame
%
% NOTE: supports only uncompressed plain avi(RIFF) files
%
% (c) by Rainer Rawer (using Matlab 5.2)
% rrawer@gmx.de
% 10/09/1999 
%-------------------------------------------------------------------------

% default declarations:
JUNK         = [74 85 78 75];
RIFF			 = [82 73 70 70];
AVI          = [65 86 73 32];
movi         = [109 111 118 105];
version      = '1.01';
lines        = 240;  % lines per frame
columns      = 320;  % colons per frame
bytes        = 1;    % bytes per pixel
margin       = 20;   % margin of arround frame that's not used for 
                     % calculating max pixel value position
no_of_frames = 1;    % no of frames to read
%-------------------------------------------------------------------------


%-------------------------------------------------------------------------
% checking if files is existing and a valid RIFF/AVI file
%-------------------------------------------------------------------------

  if nargin == 0; 
     disp(['-------------------------------']);  
     disp([' AviRead V',version, '  by R.Rawer `99'])
     disp(['-------------------------------']);
     disp([' usage: AviRead(filename,'])
     disp(['                number of frames to process,'])
     disp(['                first frame to display,'])
     disp(['                last frame to display)']) 
     error(['### no parameters']); 
  end
  if nargin < 4; option3=option2 ; end
  if nargin < 3; option2 = 0, option3= 0 ; end
  if nargin < 2; option = 0; option2 = 0, option3= 0 ; end
  
  
  
  fid = fopen(filename, 'r');
  if fid < 3; error(['### AviRead: ', filename, ' NOT found.']); end
  
  xx = uint8(fread(fid, 5000, 'uint8'));  
  if max(xx(1:4)'==[82 73 70 70]==0);							%check for: 'RIFF'
     error(['### AviRead: ', filename, ...
           ' is not a valid RIFF file.']); 
  elseif max(xx(9:12)'==[65 86 73 32]==0);					%check for: 'AVI '
          error(['### AviRead: ', filename, ...
                ' is not a valid AVI file.']); 
  end        
  fclose(fid);
  
  
%-------------------------------------------------------------------------
% Extracting AVI header information
%-------------------------------------------------------------------------

h=1;i=0;h2=0;e=1;
while e==1;
   h=h+1;
   if min(xx(h:(h+3))'==[97 118 105 104]); 					%check for ID: 'avih'
      h2=h;
      e=0;
   end 		 
end
no_of_frames=double(xx(h2+24))+double(xx(h2+25))*256+double(xx(h2+26))*256*256+double(xx(h2+27))*256*256*256;
columns     =double(xx(h2+40))+double(xx(h2+41))*256+double(xx(h2+42))*256*256+double(xx(h2+43))*256*256*256;
lines       =double(xx(h2+44))+double(xx(h2+45))*256+double(xx(h2+46))*256*256+double(xx(h2+47))*256*256*256;

i=0;h3=0;e=1;
while e==1;
   h=h+1;
   if min(xx(h:(h+3))'==[115 116 114 102]); 					%check for ID: 'strf'
      h3=h;
      e=0;
   end 		 
end
color_depth=double(xx(h3+22))+double(xx(h3+23))*256;
switch color_depth
   case 8
      bytes=1;
   case 16
      bytes=2;
   case 24 
      bytes=3;
   otherwise bytes=4;
end

e=1;
while e==1;
   h=h+1;
   if min(xx(h:(h+3))'==[109 111 118 105]); 					%check for ID: 'movi'
      e=0; 
      h1=h; 
   end 		
end
frame_length=double(xx(h1+8))+double(xx(h1+9))*256+double(xx(h1+10))*256*256+double(xx(h1+11))*256*256*256;
frame_ID=xx(h1+4:h1+7);

% re-open file to check foer actual framelength:
fid = fopen(filename, 'r');
if fid < 3; error(['### AviRead: ', filename, ' NOT found.']); end
% seek to place where 2nd frame should be:
fseek(fid,h1+4+frame_length,-1);
xx = uint8(fread(fid, 5000, 'uint8'));  
h=0;i=0;h5=0;e=1;
while e==1;
   h=h+1;
   if min(xx(h:(h+3))'==frame_ID'); 							%check for ID: frame_ID
      h5=h;
      e=0;
   end 		 
end
frame_offset=h5;

% check for compressed AVIs:
if ((lines*columns)~=(frame_length/bytes));
   error('### no compressed AVI supported !');
end;   
   
   
%display header information:
frame_ID=double(frame_ID);
disp('---------------------------------------------------------');
disp(['AviRead V',version,' by R.Rawer `99']);
disp(sprintf('   filename                 : "%s"',filename));
disp(sprintf('   number of frames to read : %d',option));
disp(sprintf('   display frame            : #%d to #%d',option2,option3));
disp('---------------------------------------------------------');
disp(sprintf('   number of data blocks : %d',no_of_frames));
disp(sprintf('   frame size            : %d x %d',columns,lines));
disp(sprintf('   colour depth          : %d (%dbyte)',color_depth,bytes));
disp(sprintf('   frame length          : %d (0x%x)',frame_length,frame_length));
disp(sprintf('   frame ID              : %c%c%c%c',frame_ID(1),frame_ID(2),frame_ID(3),frame_ID(4)));
disp(sprintf('   frame offset          : %d',frame_offset));
disp('---------------------------------------------------------');



%-------------------------------------------------------------------------
% start reading single frames
%-------------------------------------------------------------------------

% re-open file for actual reading of data:
fid = fopen(filename, 'r');
if fid < 3; error(['### AviRead: ', filename, ' NOT found.']); end
fseek(fid,h1+3,-1);

% read frames
frames=0;
if option>0; no_of_frames=option;end
while (i<no_of_frames);
   frames=frames+1;
   i=i+1;
   %disp(sprintf('processing frame %d of %d ',i,no_of_frames));
   
   frame_header = uint8(fread(fid, 8, 'uint8')');
   f_length=double(frame_header(5))+double(frame_header(6))*256+double(frame_header(7))*256*256+double(frame_header(8))*256*256*256;
   
   e=0;
   while e==0;
      if (frame_header(1:4)==JUNK );
         %found a JUNK frame and skipping it...
         %disp('reading JUNK frame...');
         xx=uint8(fread(fid, f_length, 'uint8')');
         frame_header = uint8(fread(fid, 8, 'uint8')');
         f_length=double(frame_header(5))+double(frame_header(6))*256+double(frame_header(7))*256*256+double(frame_header(8))*256*256*256;      
      elseif f_length==0;
         %found empty frame and skipping it...
         %disp('reading empty frame...');
         frame_header = uint8(fread(fid, 8, 'uint8')');
         i=i+1;
         f_length=double(frame_header(5))+double(frame_header(6))*256+double(frame_header(7))*256*256+double(frame_header(8))*256*256*256;     
      else
         %found valid frame....
         e=1;
      end   
   end

   switch bytes
      case 1
         xx = uint8(fread(fid, frame_length/bytes, 'uint8'));   
      case 2
         xx = uint8(fread(fid, frame_length/bytes, 'uint16'));
      otherwise   
         xx = uint32(fread(fid, frame_length/bytes, 'uint32'));
      end           
      
  % re arrange data as image array:
  im=reshape(xx,columns,lines);
  
  %----------------------------------------------------------------- 
  % processing data of each frame starts here                      -
  % if you don't want to display zny of the frames simply          -
  % delete the folowing lines...  (cut to cut)                     -
  %-----------------------------------------------------------------
  
  %---cut---
  % display image data if needed:
  if option2>0;
     if ((i>=option2)&(i<=option3));
        figure('name',sprintf('Frame #%d',i));
        switch bytes
           case 1
              imshow(im);colormap(gray);  
           case 2
              imshow(im);colormap(gray); 
           otherwise
              pcolor(double(im));colormap(jet);shading interp;
        end 
     end   
  end
  %---cut---
  
  %-----------------------------------------------------------------
  % raw frame data read into buffer 'xx',                          -
  % 'im' is 2 dimentional array (columsxlines)of raw data          -
  % (either uint8 or int depending on source)                      -
  %-----------------------------------------------------------------
  
  
  % your code comes here ....
  
  
  %-----------------------------------------------------------------
  % processing information in frame:
  %-----------------------------------------------------------------
  
  % Sample for processing data of each frame:
  % find position of maximum pixel value in frame:
  imd=double(im(margin:columns-margin,margin:lines-margin));
  [m,maxpos(frames,1)]=max(max(imd)+margin);
  [m,maxpos(frames,2)]=max(max(rot90(imd))+margin);

end  % end reading single frames -----------------------------------


% output read statistics:
disp('---------------------------------------------------------');
disp(sprintf('Read %d Blocks, %d valid Frames',i,frames));
disp('---------------------------------------------------------');
% plot results of maximum positions
figure('name','Results');
subplot(1,2,1)
plot(maxpos);
title('\it{Position of Maxima}','FontSize',16);
xlabel('Frame No.','FontSize',10);
ylabel('Pixel No.','FontSize',10);
subplot(1,2,2)

plot3(maxpos(:,1)',maxpos(:,2)',1:frames)
zlabel('Frame No.','FontSize',10);
ylabel('Pixel No.','FontSize',10);
xlabel('Pixel No.','FontSize',10);

output=maxpos;

disp (['script done !']);
disp(' ');
