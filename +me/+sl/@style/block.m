function block(varargin)

% import third parties
import me.sl.utils.findblocks
import me.sl.utils.filtermasktype

% Gather options from user inputs
opts = processInputs(varargin{:});

% find blocks
bhdls = findblocks('block','attr','Type','depth',opts.depth);

% Set foreground color
set( bhdls, 'ForegroundColor', 'black');

if opts.reset
    set( bhdls, 'AttributesFormatString', '');
    TF=arrayfun(@(x)filtermasktype(x,'DesignBlock'),bhdls);
    set( bhdls(~TF), 'BackgroundColor', 'white');
    set( bhdls(~TF), 'ShowName', 'on');
end


%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = false;
    IP.addParameter('reset',false,@(x)me.types.bool.validate(x));
    IP.addParameter('depth',Inf,@(x)me.types.numeric.validateNonNegative(x));
    IP.parse(varargin{:});
    options = IP.Results;
end
end

