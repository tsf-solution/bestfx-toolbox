function flipflop(varargin)

%% PREPROCESSING

% import third parties
import me.sl.utils.geteval
import me.types.bool.validateString
import me.sl.creator.mods.flipOutportTerminator

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

% get value of dialog parameters
ic = geteval(opts.blockhandle,'initial_condition');

switch(opts.clbk)
    case 'init'
        % validate value
        validateString(ic);
        % attribute format string
        setafs();
        % hide/show ports
        flipOutportTerminator('showport','!Q','blockhandle',opts.blockhandle);
end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = false;
    IP.addParameter('clbk','init',@(x)ischar(x));
    IP.addParameter('blockhandle',gcbh,@(x)ishandle(x));
    IP.parse(varargin{:});
    options = IP.Results;
    
    options.clbk = validatestring(options.clbk,{'init'});
end

%% ATTRIBUTE FORMAT STRING
function setafs() % nested function
    
    import me.types.bool.toValue
    import me.types.bool.toString
    
    afstr = '';
    if toValue(ic)
        afstr = sprintf('%sIC: %s\n',afstr,toString(ic));
    end
    set(opts.blockhandle,'AttributesFormatString',afstr);
end
end