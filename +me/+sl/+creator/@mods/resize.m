function [pos] = resize(varargin)

% import third parties

% Gather options from user inputs
opts = processInputs(varargin{:});

pos = get(opts.blockhandle,'Position');

x = pos(1);
y = pos(2);
w = pos(3)-x;
h = pos(4)-y;

% get new width
if ~isempty(opts.width)
    if ischar(opts.width)
        [w,~] = me.sl.creator.settings.size('widthType',opts.width,'qtyInOutMax',1);
    elseif isfinite(opts.width)
        w = opts.width;
    end
end

% get new height
if ~isempty(opts.height) 
    if ischar(opts.height)
        [~,h] = me.sl.creator.settings.size('heightType',opts.height,'qtyInOutMax',1);
    elseif isfinite(opts.height)
        h = opts.height;
    end
end

pos = [x y x+w y+h];

set(opts.blockhandle,'Position',pos);
    

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.addParameter('blockhandle',gcbh,@(x)ishandle(x));
    IP.addParameter('width',[],@(x)assertNonNegativeIntegerOrWidthType(x));
    IP.addParameter('height',[],@(x)assertNonNegativeIntegerOrHeightType(x));
    IP.parse(varargin{:});
    options = IP.Results;
end
end

function [tf] = assertNonNegativeInteger(x)
    if me.types.numeric.isInteger(x)
        % This results in a user-friendly assertion
        me.types.integer.validateNonNegative(x);
        tf = true;
    else
        tf = false;
    end
end

function [tf] = assertNonNegativeIntegerOrWidthType(x)
    if ischar(x)
        % This results in a user-friendly assertion
        me.sl.creator.settings.size('widthType',x);
        tf = true;
    else
        tf = assertNonNegativeInteger(x);
    end
end

function [tf] = assertNonNegativeIntegerOrHeightType(x)
    if ischar(x)
        % This results in a user-friendly assertion
        me.sl.creator.settings.size('heightType',x);
        tf = true;
    else
        tf = assertNonNegativeInteger(x);
    end
end
