function s=wgetname(h)
% Returns the window name of a window
%
% s = wgetname(h)
%
% Parameter
%  h : window number
%
% Returns:
%  s : window name

% Copyright, Lars Gregersen
% lars.gregersen@it.dk
%
% 2000.10.21, version 1.1: Now allows noninteger handles
%
% This function is freeware. You may use
% and distribute this function and its 
% associated files freely for any purpose.

if ~ishandle(h) | ~strcmp(get(h,'type'), 'figure')
    error('h is not a handle to a figure')
end

if strcmp(get(h,'numbertitle'), 'on')
  if strcmp(get(h,'integerhandle'), 'on')
      format = '%d';
  else
      format = '%9.9g';
  end
      
  if get(h,'name')
    s = sprintf(['Figure No. ' format ': %s'], h, get(h,'name'));
  else
    s = sprintf(['Figure No. ' format], h);
  end
else
  s = get(h,'name');
end
