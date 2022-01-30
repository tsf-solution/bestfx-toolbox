function bhdls = findblocks(attr, varargin)

%% PREPROCESSING

% Default values for required input arguments
narginchk(1,nargin);

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

% global search
if opts.depth == 0
    bhdls = find_system(opts.systemhandle, 'RegExp', opts.regexp, opts.attr, attr);
else
    bhdls = find_system(opts.systemhandle, 'LookUnderMasks', 'all', 'SearchDepth', opts.depth, 'RegExp', opts.regexp, opts.attr, attr);
end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = false;
    IP.addParameter('systemhandle','',@(x)ishandle(x));
    IP.addParameter('depth',0,@(x)me.types.bool.validate(x));
    IP.addParameter('regexp','off',@(x)ischar(x));
    IP.addParameter('attr','BlockType',@(x)ischar(x));
    IP.parse(varargin{:});
    options = IP.Results;
    
    options.regexp = validatestring(options.regexp,{'on','off'});
    options.attr = validatestring(options.attr,{'Type','BlockType','ReferenceBlock','MaskType'}); 
    if isempty(options.systemhandle)
        if options.depth
            options.systemhandle = get_param(gcs,'Handle');
        else
            options.systemhandle = get_param(bdroot,'Handle');
        end
    end
end
end

