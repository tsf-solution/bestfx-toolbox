function [x,y] = origin(varargin)

% valid origin types
origintypes = {...
    'default'    
    'in'
    'center'
    'out'
};

% valid block types
blocktypes = {
    'inport'
    'subsystem'
    'condition'
    'action'
    'outport'
    'busselector'
    'buscreator'
};

% Gather options from user inputs
opts = processInputs(varargin{:});

if ismember(opts.type,blocktypes)
    horz = getBlockLocationHorizontal(opts.type);
    vert = 0;
else
    horz = getStandarizedOriginHorizontal(opts.type);
    vert = 0;
end

% get standardized grid
x = horz + opts.horzShift*opts.grid;
y = vert + opts.vertShift*opts.grid;



%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('type',origintypes{1},@(x)ischar(x));
    IP.addParameter('grid',100,@(x)me.types.integer.validatePositive(x));
    IP.addParameter('horzShift',0,@(x)me.types.integer.validate(x));
    IP.addParameter('vertShift',0,@(x)me.types.integer.validate(x));
    IP.parse(varargin{:});
    options = IP.Results;

    % validate option type
    options.type = validatestring(options.type,[origintypes;blocktypes]);
end

function x = getStandarizedOriginHorizontal(type)
%     % get maximum amount of ports on one side
%     n = max([1,opts.qtyInOutMax]);
    switch(type)
        case 'in'
            x  = 2*opts.grid;
        case 'center'
            x  = 5*opts.grid;
        case 'out'
            x  = 8*opts.grid;
        otherwise % 'default'
            x  = 0;
    end
end

function [x] = getBlockLocationHorizontal(type)

    switch(type)
        case 'inport'
            x = getStandarizedOriginHorizontal('in');
        case 'outport'
            x = getStandarizedOriginHorizontal('out');
        case 'subsystem'
            x = getStandarizedOriginHorizontal('center') - 1*opts.grid;
        case 'condition'
            x = getStandarizedOriginHorizontal('center') - 1*opts.grid;
        case 'action'
            x = getStandarizedOriginHorizontal('center') + 1*opts.grid;
        case 'busselector'
            x = getStandarizedOriginHorizontal('in') + 1*opts.grid;
        case 'buscreator'
            x = getStandarizedOriginHorizontal('out') - 1*opts.grid;
        otherwise
            x = getStandarizedOriginHorizontal('center');
    end
end
end
