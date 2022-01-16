function flipflop(varargin)

%% PREPROCESSING

import me.sl.utils.geteval
import me.types.bool.validateString

% Gather options from user inputs
opts = processInputs(varargin{:});

% get value of dialog parameters
ic = geteval(opts.blockhandle,'initial_condition');

%% EXECUTE
switch(opts.clbk)
    case 'init'
        % validate value
        validateString(ic);
        % attribute format string
        setafs();
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