% Minimize, Maximize or Restore window
%
% Only work on the Win32 platform (I.e. Windows 95/98
% Windows NT and Windows 2000)
%
% Tested under Windows 98.
%
%
% wminmax(action, window_name, strict)
%
% Parameters:
%  action : 1 = minimize
%           2 = maximize
%           3 = restore
%  window_name : substring to search for in window name
%  strict : if non-zero, only an exact match is accepted
%
% Note that all windows where the substring match will be
% affected by this function

% Copyright, 2000.10.27
% Lars Gregersen <lars.gregersen@it.dk>
%
% This function is freeware. You may use
% and distribute this function and its
% associated files freely for any purpose.
