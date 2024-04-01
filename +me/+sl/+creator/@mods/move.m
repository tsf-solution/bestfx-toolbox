function [pos] = move(varargin)

% Gather options from user inputs
opts = processInputs(varargin{:});

pos = get(opts.blockhandle,'Position');

x = pos(1);
y = pos(2);
w = pos(3)-x;
h = pos(4)-y;

xo = w/2;
yo = h/2;

if ~isempty(opts.xPosition)
    x = opts.xPosition;
end

if ~isempty(opts.yPosition)
    y = opts.yPosition;
end

if strcmpi(opts.xAlign,'center')
    x = x-xo;
elseif strcmpi(opts.xAlign,'right')
    x = x-w;
end
if strcmpi(opts.yAlign,'center')
    y = y-yo;
elseif strcmpi(opts.yAlign,'bottom')
    y = y-h;
end

pos = [x y x+w y+h];

set(opts.blockhandle,'Position',pos);

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.addParameter('blockhandle',gcbh,@(x)ishandle(x));
    IP.addParameter('xPosition',[],@(x)me.types.integer.validate(x))
    IP.addParameter('yPosition',[],@(x)me.types.integer.validate(x))
    IP.addParameter('xAlign','left',@(x)ischar(x));
    IP.addParameter('yAlign','top',@(x)ischar(x));
    IP.parse(varargin{:});
    options = IP.Results;

    options.xAlign = validatestring(options.xAlign,{'left','center','right'});
    options.yAlign = validatestring(options.yAlign,{'top','center','bottom'});
end
end
