function [bhdls] = findports(varargin)

% import third parties
import me.sl.utils.findblocks

%% PREPROCESSING

% Cross-functional variables
vtyps = {'Inport','Outport'};

% Gather options from user inputs
opts = processInputs(varargin{:});


%% EXECUTE

% find blocks
bhdls = findblocks(opts.type,'depth',1);

% select subset by index
if ~isempty(opts.index)
    if ~all(opts.index <= numel(bhdls))
        error('The value %s of ''index'' is invalid. Expected index to be in range [1..%d].',mat2str(opts.index),numel(phdls));
    end
    bhdls = bhdls(opts.index);
end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('blockhandle',gcbh,@(x)ishandle(x));
    IP.addParameter('type',vtyps{1},@(x)ischar(x));
    IP.addParameter('index',[],@(x)me.types.integer.validateIndexing(x));
    IP.parse(varargin{:});
    options = IP.Results;
    
    options.type = validatestring(options.type,vtyps);
end
end
