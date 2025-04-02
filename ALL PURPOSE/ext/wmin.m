function wmin(window,strict)
% Minimize window
%
% wmin(window,strict)
%
% This function only works on the Win32 platform
%
% parameter:
%  window : substring to search for in window name
%           or window number
%  strict : if non-zero, only allow exact matches

% Copyright, Lars Gregersen
% lars.gregersen@it.dk
%
% 2000.10.27, version 1.2: Partial or exact matches
%
% This function is freeware. You may use
% and distribute this function and its
% associated files freely for any purpose.

if ~any(window)
  error('The window must be specified')
end

if nargin==1
    strict = 0;
end

if ~isstr(window) % window is a handle
    windowstr = wgetname(window);
    wminmax(1,windowstr,strict)
    set(window,'visible','off')
else
    wminmax(1,window,strict)
end
