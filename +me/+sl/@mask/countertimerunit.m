function countertimerunit(varargin)

%% PREPROCESSING

% import third parties
import me.sl.utils.geteval
import me.sl.creator.mods.flipInportConstant
import me.sl.creator.mods.flipOutportTerminator

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

% get value of dialog parameters
bvar = geteval(opts.blockhandle,'VariantType');
uppr = geteval(opts.blockhandle,'UpperLimit');
incr = geteval(opts.blockhandle,'Increment');
decr = geteval(opts.blockhandle,'Decrement');
cdtn = geteval(opts.blockhandle,'InitialCondition');
usrc = geteval(opts.blockhandle,'UpperLimitSourcePort');
isrc = geteval(opts.blockhandle,'IncrementSourcePort');
dsrc = geteval(opts.blockhandle,'DecrementSourcePort');
csrc = geteval(opts.blockhandle,'InitialConditionSourcePort');

switch(opts.clbk)
    case 'init'
        % validate value
        me.types.numeric.validatePositive(me.types.numeric.toValue(uppr));
        me.types.numeric.validatePositive(me.types.numeric.toValue(incr));
        me.types.numeric.validateNonNegative(me.types.numeric.toValue(decr));
        me.types.numeric.validate(me.types.numeric.toValue(cdtn));
        % attribute format string
        setafs();
        % hide/show ports
        flipInportConstant('UpperLimitSourcePort','lim','UpperLimit',...
            'blockhandle',opts.blockhandle,'portposition',1,'outdatatypestr','UpperLimitDataType');
        flipInportConstant('EnableSourcePort','TF','true',...
            'blockhandle',opts.blockhandle,'portposition',2);
        flipInportConstant('IncrementSourcePort','incr','Increment',...
            'blockhandle',opts.blockhandle,'portposition',3,'outdatatypestr','IncrementDataType');
        flipInportConstant('DecrementSourcePort','decr','Decrement',...
            'blockhandle',opts.blockhandle,'portposition',4,'outdatatypestr','DecrementDataType');
        flipInportConstant('InitialConditionSourcePort','x0','InitialCondition',...
            'blockhandle',opts.blockhandle,'portposition',5,'outdatatypestr','InitialValueDataType');
        flipInportConstant('ResetSourcePort','rs','false',...
            'blockhandle',opts.blockhandle,'portposition',6);
        flipOutportTerminator('CounterTimerValueSinkPort','n',...
            'blockhandle',opts.blockhandle,'portposition',2);
        flipOutportTerminator('CounterTimerStateSinkPort','st',...
            'blockhandle',opts.blockhandle,'portposition',1);
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
    uppr = compactfloat(toValue(uppr));
    incr = compactfloat(toValue(incr));
    decr = compactfloat(toValue(decr));
    cdtn = compactfloat(toValue(cdtn));
    
    afstr = '';
    % variant
    if not(isequal(decr,'0'))
        afstr = sprintf('%s%s\n',afstr,sprintf('Charging %s',bvar));
    else
        afstr = sprintf('%s%s\n',afstr,sprintf('%s',bvar));
    end
    % upper limit
    if isequal(usrc,'off')
        afstr = sprintf('%sUpper Limit: %s\n',afstr,uppr);
    end
    % increment & decrement
    if not(isequal(incr,'1')) || not(isequal(decr,'0'))
        if isequal(isrc,'off') && isequal(dsrc,'off') 
            afstr = sprintf('%s%s\n',afstr,sprintf('INC=%s|DEC=%s',incr,decr));
        elseif isequal(psrc,'off')
            afstr = sprintf('%s%s\n',afstr,sprintf('INC=%s',incr));
        elseif isequal(dsrc,'off')
            afstr = sprintf('%s%s\n',afstr,sprintf('DEC=%s',decr));
        end
    end
    %initial condition
    if isequal(csrc,'off') 
        if not(isequal(cdtn,'0'))
            afstr = sprintf('%sIC: %s\n',afstr,cdtn);
        end
    end
    
    set(opts.blockhandle,'AttributesFormatString',afstr);
end
end