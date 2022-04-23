function pulseselector(varargin)

%% PREPROCESSING

% import third parties
import me.sl.utils.geteval
import me.sl.creator.mods.flipInportConstant

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

% get value of dialog parameters
amnt = geteval(opts.blockhandle,'Maximum');
slct = geteval(opts.blockhandle,'Subset');
asrc = geteval(opts.blockhandle,'MaximumSourcePort');
ssrc = geteval(opts.blockhandle,'SubsetSourcePort');

switch(opts.clbk)
    case 'init'
        % validate value
        me.types.integer.validatePositive(me.types.numeric.toValue(amnt));
        me.types.integer.validateNonNegative(me.types.numeric.toValue(slct));
        validateattributes(me.types.numeric.toValue(slct),{'numeric'},{'<=',me.types.numeric.toValue(amnt)});
        % attribute format string
        setafs();
        % hide/show ports
        flipInportConstant('MaximumSourcePort','nmax','Maximum',...
            'blockhandle',opts.blockhandle,'portposition',2,'outdatatypestr','MaximumDataType');
        flipInportConstant('SubsetSourcePort','n','Subset',...
            'blockhandle',opts.blockhandle,'portposition',3,'outdatatypestr','SubsetDataType');
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
    amnt = compactfloat(toValue(amnt));
    slct = compactfloat(toValue(slct));
    
    afstr = '';
    % subset amount
    if isequal(ssrc,'off')
        afstr = sprintf('%s%s out of ',afstr,slct);
    else
        afstr = sprintf('%sn out of ',afstr);
    end
    % total amount
    if isequal(asrc,'off') 
        afstr = sprintf('%s%s',afstr,amnt);
    else
        afstr = sprintf('%snmax',afstr);
    end
    
    set(opts.blockhandle,'AttributesFormatString',afstr);
end

%% MASK PARAMETER OPERATBILITY
function setopr() % nested function
    import me.sl.creator.mods.setmaskenable
    import me.types.bool.not

    setmaskenable('Maximum','enable',not(asrc));
    setmaskenable('MaximumDataType','enable',not(asrc));
    setmaskenable('Subset','enable',not(ssrc));
    setmaskenable('SubsetDataType','enable',not(ssrc));
end
end