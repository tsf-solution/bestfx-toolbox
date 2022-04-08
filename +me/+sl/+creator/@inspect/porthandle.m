function [phdls] = ports(varargin)

%% PREPROCESSING

% Cross-functional variables
vtyps = {'Inport','Outport','Ifaction'};

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE
PH = get(opts.blockhandle,'PortHandles');

if sum(strcmpi(opts.type,'Ifaction'))
    phdls = arrayfun(@(c)c,PH.Ifaction(:));
elseif sum(strcmpi(opts.type,'Outport'))
    phdls = arrayfun(@(c)c,PH.Outport(:));
else
    phdls = arrayfun(@(c)c,PH.Inport(:));
end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('blockhandle',gcbh,@(x)ishandle(x));
    IP.addParameter('type',vtyps{1},@(x)ischar(x));
    IP.parse(varargin{:});
    options = IP.Results;
    
    options.type = validatestring(options.type,vtyps);
end
end