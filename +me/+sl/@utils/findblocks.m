function bhdls = findblocks(attr, varargin)

%% PREPROCESSING

% Default values for required input arguments
narginchk(1,nargin);

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

if opts.depth
    bhdls = find_system(opts.shdl, 'LookUnderMasks', 'all', 'SearchDepth', opts.depth, 'RegExp', opts.regexp, opts.attr, attr);
else
    bhdls = find_system(opts.shdl, opts.attr, attr);
end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = false;
    IP.addParameter('shdl','',@(x)ishandle(x));
    IP.addParameter('depth',0,@(x)me.types.bool.validate(x));
    IP.addParameter('regexp','off',@(x)ischar(x));
    IP.addParameter('attr','BlockType',@(x)ischar(x));
    IP.parse(varargin{:});
    options = IP.Results;
    
    options.regexp = validatestring(options.regexp,{'on','off'});
    options.attr = validatestring(options.attr,{'Type','BlockType','ReferenceBlock'}); 
    if isempty(options.shdl)
        if options.depth
            options.shdl = get_param(gcs,'Handle');
        else
            options.shdl = get_param(bdroot,'Handle');
        end
    end
end
end

