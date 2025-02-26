function [id] = layoutwindow(obj,varargin)

%% PREPROCESSING

% import third parties
import me.env.screendevice

% Gather options from input arguments
opts = processInputs(varargin{:});

% validate figure handle
if ~ishandle(obj.handle)
    id = nan;
    return;
else
    id = obj.handle.Number;
end

%% EXECUTE
    
% select second monitor
sdn = screendevice('name','next');
if sdn.total > 1
    sdp = screendevice('name','primary');
    sdn.y = sdp.h-(sdn.y+sdn.h);
end

% set optimized os calculated screen size
x = sdn.x;
y = sdn.y;
dx = floor(sdn.w/opts.cols);
dy = floor(sdn.h/opts.rows);

switch(mod(id,8))
    case 1
        set(obj.handle,'outerposition',[x y+dy dx dy]);
    case 2
        set(obj.handle,'outerposition',[x+dx y+dy dx dy]);
    case 3
        set(obj.handle,'outerposition',[x+2*dx y+dy dx dy]);
    case 4
        set(obj.handle,'outerposition',[x+3*dx y+dy dx dy]);
    case 5
        set(obj.handle,'outerposition',[x y dx dy]);
    case 6
        set(obj.handle,'outerposition',[x+dx y dx dy]);
    case 7
        set(obj.handle,'outerposition',[x+2*dx y dx dy]);
    case 0
        set(obj.handle,'outerposition',[x+3*dx y dx dy]);
end

% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('rows',2,@(x)me.types.integer.validatePositive(x));
    IP.addParameter('cols',4,@(x)me.types.integer.validatePositive(x));
    IP.parse(varargin{:});
    options = IP.Results;
end 
end