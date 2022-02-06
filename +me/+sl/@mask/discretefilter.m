function discretefilter(varargin)

%% PREPROCESSING

% import third parties
import me.sl.utils.geteval
import me.sl.creator.mods.flipInportConstant

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

% get value of dialog parameters
bvar = geteval(opts.blockhandle,'BlockSubtypeVariant');
fltr = geteval(opts.blockhandle,'FilterCoefficient');
cdtn = geteval(opts.blockhandle,'InitialCondition');
fsrc = geteval(opts.blockhandle,'FilterCoefficientSourcePort');
csrc = geteval(opts.blockhandle,'InitialConditionSourcePort');
% drsrc = geteval(opts.blockhandle,'ResetSourcePort');

switch(opts.clbk)
    case 'init'
        % validate popup
        bvar = validatestring(bvar,{'Lowpass','Highpass'});
        % validate value
        me.types.numeric.validateNormalization(me.types.numeric.toValue(fltr));
        me.types.numeric.validate(me.types.numeric.toValue(cdtn));
        % attribute format string
        setafs();
        % hide/show ports
        flipInportConstant('FilterCoefficientSourcePort','T','FilterCoefficient',...
            'blockhandle',opts.blockhandle,'portposition',2,'outdatatypestr','FilterCoefficientDataType');
        flipInportConstant('InitialConditionSourcePort','x0','InitialCondition',...
            'blockhandle',opts.blockhandle,'portposition',3,'outdatatypestr','InitialConditionDataType');
        flipInportConstant('ResetSourcePort','rs','false',...
            'blockhandle',opts.blockhandle,'portposition',4);
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
    fltr = compactfloat(toValue(fltr));
    cdtn = compactfloat(toValue(cdtn));
    
    afstr = '';
    % variant
    afstr = sprintf('%s%s\n',afstr,'%<BlockSubtypeVariant>');
    % filter coefficient
    if isequal(fsrc,'off') 
        afstr = sprintf('%sFilter Coefficient: %s\n',afstr,fltr);
    end
    %initial condition
    if isequal(csrc,'off') 
        if not(isequal(cdtn,'0'))
            afstr = sprintf('%sIC: %s\n',afstr,cdtn);
        end
    end
    
    set(opts.blockhandle,'AttributesFormatString',afstr);
end

%% MASK PARAMETER OPERATBILITY
function setopr() % nested function
    import me.sl.creator.mods.setmaskenable
    import me.types.bool.not

    setmaskenable('FilterCoefficient','enable',not(fsrc));
    setmaskenable('FilterCoefficientDataType','enable',not(fsrc));
    setmaskenable('InitialCondition','enable',not(csrc));
    setmaskenable('InitialConditionDataType','enable',not(csrc));
end

%% BLOCK SUBTYPE VARIANT
function setvar() % nested function
    import me.sl.creator.inspect.blockhandle
    import me.sl.creator.inspect.blockfullpath
    
    % handle variant subsystem: VariantType
    vblk = blockfullpath(opts.blockhandle);
    vhdl = blockhandle([vblk '/' 'VariantType']);
    
    if contains(bvar,'Lowpass')
        set(vhdl,'OverrideUsingVariant','VariantTypeLowpass');
    elseif contains(bvar,'Highpass')
        set(vhdl,'OverrideUsingVariant','VariantTypeHighpass');
    else
        error('no valid type selected in block ''%s''',vblk);
    end
end
end