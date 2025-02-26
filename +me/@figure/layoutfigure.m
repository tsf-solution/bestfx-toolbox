function [num] = layoutfigure(obj,varargin)

%% PREPROCESSING

% Gather options from input arguments
opts = processInputs(varargin{:});

% validate figure handle
if ~ishandle(obj.handle)
    num = nan;
    return;
end

%% EXECUTE

% propagate settings
obj.rows = opts.rows;
obj.cols = opts.cols;
num = obj.rows * obj.cols;
obj.num = num;
obj.axes = zeros(obj.num,1);

% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('rows',1,@(x)me.types.integer.validatePositive(x));
    IP.addParameter('cols',1,@(x)me.types.integer.validatePositive(x));
    IP.parse(varargin{:});
    options = IP.Results;
end 
end