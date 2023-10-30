function validate(varargin)

%% PREPROCESSING

% import third parties
import me.sl.utils.geteval

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

% get value of dialog parameters
bvar = geteval(opts.blockhandle,'BlockSubtypeVariant');
lowr = geteval(opts.blockhandle,'LowerLimit');
uppr = geteval(opts.blockhandle,'UpperLimit');
lsrc = geteval(opts.blockhandle,'LowerLimitSourcePort');
usrc = geteval(opts.blockhandle,'UpperLimitSourcePort');

switch(opts.clbk)
    case 'init'
        % validate popup
        bvar = validatestring(bvar,{'Value Inside','Value Below','Value Above','Stuck','Stuck Inside','Stuck Below','Stuck Above'});
        % validate value
        me.types.numeric.validateRegular(me.types.numeric.toValue(lowr));
        me.types.numeric.validateRegular(me.types.numeric.toValue(uppr));
        % attribute format string
        setafs();        
        % hide/show ports
        setport();
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
    
    options.clbk = validatestring(options.clbk,{'init','variant','port'});
end

%% ATTRIBUTE FORMAT STRING
function setafs() % nested function
    
    import me.types.numeric.toValue
    import me.string.compactfloat
    
    % trim decimal digits
    lowr = compactfloat(toValue(lowr));
    uppr = compactfloat(toValue(uppr));
    
    afstr = '';
    % variant
    afstr = sprintf('%s%s\n',afstr,'%<BlockSubtypeVariant>');
    
    if contains(bvar,{'Inside'}) && isequal(lsrc,'off') && isequal(usrc,'off')
            afstr = sprintf('%sInterval [%s .. %s]\n',afstr,lowr,uppr); 
    elseif contains(bvar,{'Inside','Below','Above'})
        % lower limit
        if contains(bvar,{'Inside','Below'}) && isequal(lsrc,'off')
            afstr = sprintf('%sLower Limit: %s\n',afstr,lowr);
        end
        % upper limit
        if contains(bvar,{'Inside','Above'}) && isequal(usrc,'off')
            afstr = sprintf('%sUpper Limit: %s\n',afstr,uppr);
        end
    end
    
    set(opts.blockhandle,'AttributesFormatString',afstr);
end

%% SHOW/HIDE BLOCK PORTS
function setport()
    import me.sl.creator.mods.flipInportConstant
    import me.sl.creator.mods.flipOutportTerminator
    
    if contains(bvar,{'Above','None'})
        llsp='off';
    else
        llsp='LowerLimitSourcePort';
    end
    
    if contains(bvar,{'Below','None'})
        ulsp='off';
    else
        ulsp='UpperLimitSourcePort';
    end
    
    flipInportConstant(llsp,'lwr','LowerLimit',...
        'blockhandle',opts.blockhandle,'portposition',2,'outdatatypestr','LowerLimitDataType');
    flipInportConstant(ulsp,'upr','UpperLimit',...
        'blockhandle',opts.blockhandle,'portposition',3,'outdatatypestr','UpperLimitDataType');
end

%% MASK PARAMETER OPERATBILITY
function setopr() % nested function
    import me.sl.creator.mods.setmaskenable
    import me.types.bool.not

    setmaskenable('UpperLimit','enable',not(usrc));
    setmaskenable('UpperLimitDataType','enable',not(usrc));
    setmaskenable('LowerLimit','enable',not(lsrc));
    setmaskenable('LowerLimitDataType','enable',not(lsrc));
end

%% BLOCK SUBTYPE VARIANT
function setvar() % nested function
    import me.sl.creator.inspect.blockhandle
    import me.sl.creator.inspect.blockfullpath
    
    % handle variant subsystem: VariantType
    vblk = blockfullpath(opts.blockhandle);
    vhdl = blockhandle([vblk '/' 'VariantType']);
    
    if contains(bvar,'Stuck')
        set(vhdl,'OverrideUsingVariant','VariantTypeStuck');
    else
        set(vhdl,'OverrideUsingVariant','VariantTypePassThrough');
    end
    
    % handle variant subsystem: VariantRange
    rblk = blockfullpath(opts.blockhandle);
    rhdl = blockhandle([rblk '/' 'VariantRange']);
    
    if contains(bvar,'Inside')
        set(rhdl,'OverrideUsingVariant','VariantRangeInside');
        setMaskVisibility('on',{'LowerLimitSourcePort','LowerLimit','LowerLimitDataType'});
        setMaskVisibility('on',{'UpperLimitSourcePort','UpperLimit','UpperLimitDataType'});
    elseif contains(bvar,'Above')
        set(rhdl,'OverrideUsingVariant','VariantRangeAbove');
        setMaskVisibility('off',{'LowerLimitSourcePort','LowerLimit','LowerLimitDataType'});
        setMaskVisibility('on',{'UpperLimitSourcePort','UpperLimit','UpperLimitDataType'});
    elseif contains(bvar,'Below')
        set(rhdl,'OverrideUsingVariant','VariantRangeBelow');
        setMaskVisibility('on',{'LowerLimitSourcePort','LowerLimit','LowerLimitDataType'});
        setMaskVisibility('off',{'UpperLimitSourcePort','UpperLimit','UpperLimitDataType'});
    else
        set(rhdl,'OverrideUsingVariant','VariantRangeNone');
        setMaskVisibility('off',{'LowerLimitSourcePort','LowerLimit','LowerLimitDataType'});
        setMaskVisibility('off',{'UpperLimitSourcePort','UpperLimit','UpperLimitDataType'});
    end
end
end

function setMaskVisibility(onoff,list)
    import me.sl.creator.mods.setmaskvisibility
%     me.types.bool.validate(onoff)
    cellfun(@(c)setmaskvisibility(c,'enable',onoff),list);
end