function [bhdl] = flipInportConstant(prop,blockname,value,varargin)

% import third parties
import me.sl.creator.mods.flip
import me.sl.creator.inspect.porthandle

% Required input arguments
narginchk(2,nargin);

% Gather options from user inputs
opts = processInputs(varargin{:});

% check property which control flip
try
    if me.types.bool.isEnable(prop)
        propval = prop;
    else
        propval = get(opts.blockhandle,prop);
    end
catch ME
    throw(ME);
end

% flip outport terminator
[bhdl,btyp] = flip('blockhandle',opts.blockhandle,'maskparameter',propval,'blockname',blockname,'onblocktype','Inport','offblocktype','Constant');

% constant settings
if isequal(btyp, 'Constant')
    set(bhdl,'Value',value);
    set(bhdl,'OutDataTypeStr',opts.outdatatypestr);
    set(bhdl,'BackgroundColor','orange');
% inport settings
elseif isequal(btyp, 'Inport')
    set(bhdl, 'ForegroundColor','green');
    if isnumeric(opts.portposition)
        n = numel(porthandle('blockhandle',opts.blockhandle,'type','Inport'));
        opts.portposition = min(n,opts.portposition);
        set(bhdl, 'Port',num2str(opts.portposition));
    end
end


%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.addParameter('blockhandle',gcbh,@(x)ishandle(x));
    IP.addParameter('portposition','end',@(x)me.types.integer.validatePositive(x));
    IP.addParameter('outdatatypestr','Inherit: Inherit from ''Constant value''',@(x)ischar(x));
    IP.parse(varargin{:});
    options = IP.Results;
end
end