function pulsedivider(varargin)

%% PREPROCESSING

% import third parties
import me.sl.utils.geteval
import me.sl.creator.mods.flipInportConstant

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

% get value of dialog parameters
dvsr = geteval(opts.blockhandle,'Divisor');
dsrc = geteval(opts.blockhandle,'DivisorSourcePort');


switch(opts.clbk)
    case 'init'
        % validate value
        me.types.integer.validatePositive(me.types.numeric.toValue(dvsr));
        % attribute format string
        setafs();
        % hide/show ports
        flipInportConstant('DivisorSourcePort','k','Divisor',...
            'blockhandle',opts.blockhandle,'portposition',2,'outdatatypestr','DivisorDataType');
        % mask parameter operability
        setopr();
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
    
    import me.types.numeric.toValue
    import me.string.compactfloat
    
    % trim decimal digits
    dvsr = compactfloat(toValue(dvsr));
    
    afstr = '';
    % devisor
    if not(isequal(dvsr,'2'))
        if isequal(dsrc,'off')
            afstr = sprintf('%sDivisor: %s\n',afstr,dvsr);
        end
    end
    
    set(opts.blockhandle,'AttributesFormatString',afstr);
end

%% MASK PARAMETER OPERATBILITY
function setopr() % nested function
    import me.sl.creator.mods.setmaskenable
    import me.types.bool.not

    setmaskenable('Divisor','enable',not(dsrc));
    setmaskenable('DivisorDataType','enable',not(dsrc));
end
end