function [phdl] = porthandle(bhdl, varargin)

% handle input arguments
if nargin < 1
    bhdl = gcbh;
end

%% PREPROCESSING

% Cross-functional variables
vtyps = {'Inport','Outport','Ifaction'};

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE
PH = get(bhdl,'PortHandles');

if sum(strcmpi(opts.type,'Ifaction'))
    phdl = arrayfun(@(c)c,PH.Ifaction(:));
elseif sum(strcmpi(opts.type,'Outport'))
    phdl = arrayfun(@(c)c,PH.Outport(:));
else
    phdl = arrayfun(@(c)c,PH.Inport(:));
end

% select subset by index
if ~isempty(opts.index)
    if ~all(opts.index <= numel(phdl))
        error('The value %s of ''index'' is invalid. Expected index to be in range [1..%d].',mat2str(opts.index),numel(phdl));
    end
    phdl = phdl(opts.index);
end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('type',vtyps{1},@(x)ischar(x));
    IP.addParameter('index',[],@(x)me.types.integer.validateIndexing(x));
    IP.parse(varargin{:});
    options = IP.Results;
    
    options.type = validatestring(options.type,vtyps);
end
end