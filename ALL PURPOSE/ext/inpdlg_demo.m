% Demo script for running inpdlg version 1.30

% Program simulating Frequency measurments
N_FDat = 1024;

colorlist = {'red','blue','green','yellow','magenta'};
distlist  = 'Normal|Poisson|Rayleigh|Weibull';
% Program creating simulated random input data (Frequencies, Amplitudes, Phases,...)
prompt = {...
   	'Enter number of frequency measurements:', ...				%  1
      'Enter 3 numbers:', ...												%  2
      'Enter sampling freq(KHz):',...									%  3
      'Enter signal length (in samples) and FFT size:',...		%  4
      'Enter the colormap name:', ...									%  5
      'Choose color (popup box):', ...									%  6
      'Choose color (list box):', ...									%  7
      'Enter input Bandwidth range(KHz):',...						%  8
      'Enter number of hopper peaks:', ...							%  9
      'Choose distribution:', ...										% 10
		'Enter signal Amplitude (...):',...								% 11      
      'Choose distribution (list box):'};								% 12
dlgTitle='Random frequency measurements Input';
NumLines=[1 12; 3 9; 1 0; 1 0; 1 10; 1 0; length(colorlist) 0; 1 0; ...
          1 2; 5 12; 1 0; 4 0];
DefAns=  {num2str(N_FDat), {'12','3.45','6.70'}, num2str(1024), ...
       [num2str(512),' ',num2str(8192)], 'hsv', ...
       {'red','blue','green','yellow','magenta'}, colorlist, [num2str(1000),' ', ...
       num2str(1250)], num2str(4), 'Normal|Poisson|Rayleigh|Weibull' , ...
       '1.000', distlist};
% PromptDef(1,:) = 0 for edit box
%                  N for Popup menu(N is  the initial selection)    
%                 -N for ListBox(ListInit{N} is the initial selection)    
PromptDef(1,:)=  [0, 0, 0, 0, 0, 3, -1, 0, 0, 4, 0, -2];
% PromptDef(2,:) = 1 for initially disabled Quests
%      for ListBox:	1  initially disabled ListBox
%                  	2  Single item selection ListBox
%                    3  Single item selection + initially disabled ListBox
PromptDef(2,:)=  [1, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0,  2];
Resize = 'on';
% ListInit{N} is the initial selection for ListBox(N) - see PromptDef(1,:)
ListInit = {[1,2,4], [3] };

% For Input dialog consisting of frames of flags exclusively:
%prompt = {};
%DefAns = {};
%NumLines = 1;

% CheckBox\RadioButton input
clear AnsFlg1;
CCflg = logical(1);ACflg = logical(0);

[AAA_FMflg,AA_AMflg] = deal(logical(0));
AB_AMflg = 1;

% typ - 'chk' for checkboxes
MesMet = struct('Frm_Nam',{'Measure Method:'},'typ',{'chk'}, ...
                'ACflg',{{ACflg; 'Auto Correl'; 0}}, ...
                'CCflg',{{CCflg; 'Correl Coef'}},'En_Quest',{{[401 402];[1 2 3]}});
%  ACflg - {{ACflg, 			% Initial Value for AnsFlg1{1}.ACflg
%            'Auto Correl',% Name Tag for AnsFlg1{1}.ACflg
%            L}} 				% L=1 AnsFlg1{1}.ACflg initially disabled
%                          %  =0 AnsFlg1{1}.ACflg initially enabled (default)
%  En_Quest - {{[401 402]; % checking ACflg will enable items 1 2 of Frame 4 (AnsFlg1(4))
%                          % unchecking ACflg will disable them
%               [1 2 3];}} % checking CCflg will enable Prompts 1 2 3
%                          % unchecking CCflg will disable them
AnsFlg1(1)={MesMet};
MesMet = struct('Frm_Nam',{'Measur Metod:'},'typ',{'chk'}, ...
   'ACflg',{CCflg},'CCflg',{{ACflg;1}},'CCflg1',{{ACflg; 'Pattern figure';1}});
AnsFlg1(2)={MesMet};

% typ - 'rad' for radiobuttons
MesMet = struct('Frm_Nam',{'Measure MetMes Method:'},'typ',{'rad'}, ...
   'AAA_FMflg',{{AAA_FMflg}}, ...
   'AA_AMflg',{{AA_AMflg}}, ...
   'AB_AMflg',{{AB_AMflg}}, ...
   'En_Quest', {{[];[202 7 203]}});
AnsFlg1(3)={MesMet};
MesMet = struct('Frm_Nam',{'Measure Met:'},'typ',{'rad'}, ...
   'ABA_FMflg',{{AAA_FMflg;1;'AB FMflg'}}, 'AB_AMflg',{{AA_AMflg;1}}, 'AC_AMflg',{{0}}, ...
   'AD_AMflg',{{AB_AMflg;'Signal figure'}},'En_Quest',{{[1 8 9 101 102];[];[1 3 101]}});
AnsFlg1(4)={MesMet};

% For Input dialog consisting of edit boxes exclusively:
%AnsFlg1 = {};

[Answer, figfmen1, AnsFlg1] =inpdlg(prompt, dlgTitle, NumLines, ...
             DefAns, PromptDef, AnsFlg1, Resize, ListInit)

% Display AnsFlg1
%AnsFlg1{:}
       
if isempty(figfmen1), 
   disp('Random Frequency measurements Stage skipped.'); 
   return;
else,
   if isempty(Answer),
      disp(['Random Frequency measurements input dialog didn`t pro',...
            'vide any output']); 
      disp('Random Frequency measurements Stage skipped.'); 
      return;
   else,
      [N_FDat, count]  = sscanf(Answer{1},'%d',1);
      [N_FFT, count]  = sscanf(Answer{4},'%*d %d',1);
      [M_Color, count] = sscanf(Answer{6},'%s',1);
      
      Arr3 = str2num(strvcat(Answer{2}));
      disp('Answer{7} =');								% Display ListBoxes` results 
      disp(Answer{7});
      disp('Answer{10} =');	 
      disp(Answer{12});
      
      [ACflg, CCflg] = deal(AnsFlg1{1}.ACflg, AnsFlg1{1}.CCflg);
   end;
end;

