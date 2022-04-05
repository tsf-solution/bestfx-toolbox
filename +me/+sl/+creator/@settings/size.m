function [width,height] = size(varargin)

% valid widthType
validwidthtypes = {...
    'normal'
    'tiny'
    'mini'
    'port'
    'operator'
    'small'
    'large'
    'huge'
    'cube'
};

% valid heightType
validheighttypes = {...
    'standard'
    'compact'
    'port'
    'mini'
    'operator'
    'extra'
};


% Gather options from user inputs
opts = processInputs(varargin{:});

% get standardized height
height = getStandardizedHeight(opts.heightType);
% check if block should look like a cube
if ismember(opts.widthType,'cube')
    % width could be same as height
    width = height;
else
    % get standardized width
    width = getStandardizedWidth(opts.widthType);
end


%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('widthType',validwidthtypes{1},@(x)ischar(x));
    IP.addParameter('heightType',validheighttypes{1},@(x)ischar(x));
    IP.addParameter('qtyInOutMax',1,@(x)me.types.integer.validateNonNegative(x));
    IP.parse(varargin{:});
    options = IP.Results;

    % validate option width type
    options.widthType = validatestring(options.widthType,validwidthtypes);
    % validate option height type
    options.heightType = validatestring(options.heightType,validheighttypes);
end

function h = getStandardizedHeight(type)
    
    % get maximum amount of ports on one side
    n = max([1,opts.qtyInOutMax]);
    
    switch(type)
        case 'compact'
            h = n*14; % rename, convert, overwrite, ...
        case 'standard'
            h = n*30; % subsystem
        case 'extra'
            h = n*32; % unit conversion, ...
            if n==1,h=h+10;end
        % special sizes
        case 'mini'
            h = 20; % sum, terminator, ground, ...
        case 'port'
            h = 14; % inport, outport
        case 'operator'
            h = n*30; % logical operator, minmax, add, ...
        otherwise % standard
            h = n*30;
    end
end

function w = getStandardizedWidth(type)
    
    switch(type)
        case 'tiny'
            w = 5; % bus selector, bus creator, mux, demux, ...
        case 'small'
            w = 70; % unit conversion, discrete filter, ...
        case 'normal'
            w = 100; % subsystem
        case 'large'
            w = 180; % subsystem
        case 'huge'
            w = 300; % subsystem
        % special sizes
        case 'mini'
            w = 20; % sum, terminator, ground, ...
        case 'port'
            w = 30; % inport, outport
        case 'operator'
            w = 30; % logical operator, minmax, add, ...
        otherwise % normal
            w = 100;
    end
end
end
