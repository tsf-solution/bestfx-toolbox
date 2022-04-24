function debounceunit(varargin)

%% PREPROCESSING

% import third parties
import me.sl.utils.geteval
import me.sl.creator.mods.flipInportConstant

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

% get value of dialog parameters
bvar = geteval(opts.blockhandle,'BlockSubtypeVariant');
sndt = geteval(opts.blockhandle,'Samples');
ssrc = geteval(opts.blockhandle,'SamplesSourcePort');
cvrt = geteval(opts.blockhandle,'SamplesConversion');
dt = geteval(opts.blockhandle,'SampleTime');

switch(opts.clbk)
    case 'init'
        % validate popup
        bvar = validatestring(bvar,{'Holding Element','Switch-On Delay','Switch-Off Delay'});
        % validate value
        me.types.integer.validateNonNegative(me.types.numeric.toValue(sndt));
        me.types.numeric.validateSampleTime(me.types.numeric.toValue(dt));
        % attribute format string
        setafs();
        % hide/show ports
        flipInportConstant('SamplesSourcePort','n','Samples',...
            'blockhandle',opts.blockhandle,'portposition',2,'outdatatypestr','SamplesDataType');
        % mask parameter operability
        setopr();
        % block variant type
        setvar();
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
    sndt = compactfloat(toValue(sndt));
    dt = compactfloat(toValue(dt));
    
    afstr = '';
    % variant
    afstr = sprintf('%s%s\n',afstr,'%<BlockSubtypeVariant>');
    % samples
    if isequal(ssrc,'off')
        if isequal(sndt,'0')
            afstr = sprintf('%s%s\n',afstr,'block has no effect');
        else
            afstr = sprintf('%s%s\n',afstr,SamplesToTimeInterval(cvrt,sndt,dt));
        end
    end
    
    set(opts.blockhandle,'AttributesFormatString',afstr);
end

%% MASK PARAMETER OPERATBILITY
function setopr() % nested function
    import me.sl.creator.mods.setmaskenable
    import me.types.bool.not

    setmaskenable('Samples','enable',not(ssrc));
    setmaskenable('SamplesDataType','enable',not(ssrc));
    setmaskenable('SamplesConversion','enable',not(ssrc));
end

%% BLOCK SUBTYPE VARIANT
function setvar() % nested function
    import me.sl.creator.inspect.blockhandle
    import me.sl.creator.inspect.blockfullpath
    
    % handle variant subsystem: VariantControl
    cblk = blockfullpath(opts.blockhandle);
    chdl = blockhandle([cblk '/' 'VariantControl']);
    
    if contains(bvar,'Switch-On')
        set(chdl,'OverrideUsingVariant','VariantControlNormal');
    elseif contains(bvar,'Switch-Off')
        set(chdl,'OverrideUsingVariant','VariantControlSwapped');
    else
        set(chdl,'OverrideUsingVariant','VariantControlNoReset');
    end
    
    % handle variant subsystem: VariantDebounce
    dblk = blockfullpath(opts.blockhandle);
    dhdl = blockhandle([dblk '/' 'VariantDebounce']);
    
    if isequal(sndt,'0')
        set(dhdl,'OverrideUsingVariant','VariantDebouncePassThrough');
    elseif contains(bvar,'Switch-On')
        set(dhdl,'OverrideUsingVariant','VariantDebounceZeroHold');
    else
        set(dhdl,'OverrideUsingVariant','VariantDebounceCaptureHold');
    end
end
end

function [str] = SamplesToTimeInterval(flag,samples,sampletime)

    % samples
    if isequal(flag,'off') || isequal(sampletime,'-1')
        str = sprintf('%sx samples',samples);
    else % seconds
        timeinterval = str2double(sampletime)*str2double(samples);
        str = sprintf('%g seconds',timeinterval);
    end
end
