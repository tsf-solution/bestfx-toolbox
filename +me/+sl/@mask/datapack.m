function datapack(varargin)

%% PREPROCESSING

% import third parties
import me.sl.utils.geteval

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

% get value of dialog parameters
bvar = geteval(opts.blockhandle,'BlockSubtypeVariant');
expo = geteval(opts.blockhandle,'Length');
gain = geteval(opts.blockhandle,'Scale');
bias = geteval(opts.blockhandle,'Offset');
type = geteval(opts.blockhandle,'OutputDataType');

switch(opts.clbk)
    case 'init'
        % validate popup
        bvar = validatestring(bvar,{'Unsigned','Signed','Floating-Point'});
        % validate value
        me.types.integer.validatePositive(me.types.numeric.toValue(expo));
        me.types.numeric.validateRegularNonZero(me.types.numeric.toValue(gain));
        me.types.numeric.validateRegular(me.types.numeric.toValue(bias));
        % attribute format string
        setafs();
        % mask parameter operability
        setopr();
        % block variant type
        setvar();
        % mask display
        setdisp();
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
    
    afstr = '';
    
    if startsWith(bvar,'Float')
        % trim decimal digits
        gain = compactfloat(toValue(gain));
        bias = compactfloat(toValue(bias));
        % variant
        afstr = sprintf('%s%s\n',afstr,bvar);
        % gain
        if ~isequal(gain,'1')
            afstr = sprintf('%sScale: %s\n',afstr,gain);
        end
        % bias
        if ~isequal(bias,'0')
            afstr = sprintf('%sOffset: %s\n',afstr,bias);
        end
    else
        % variant
        afstr = sprintf('%s%s %s Bits\n',afstr,expo,bvar);
        % gain & bias
        if ~isequal(gain,'1') || ~isequal(bias,'0')
            gain = toValue(gain);
            bias = toValue(bias);
            if startsWith(bvar,'Signed')
                expo = toValue(expo)-1;
                expolwr = -2^expo;
                expoupr = 2^expo-1;
            else
                expolwr = 0;
                expoupr = 2^toValue(expo)-1;
            end
            physlwr = expolwr*gain+bias;
            physupr = expoupr*gain+bias;
            if startsWith(get(opts.blockhandle,'MaskType'),'DataPack')
                afstr = sprintf('%sFrom [%g..%g] To [%d..%d]\n',afstr,physlwr,physupr,expolwr,expoupr);
            else
                afstr = sprintf('%sFrom [%d..%d] To [%g..%g]\n',afstr,expolwr,expoupr,physlwr,physupr);
            end
            
        end
    end
    
    set(opts.blockhandle,'AttributesFormatString',afstr);
end

%% MASK PARAMETER OPERATBILITY
function setopr() % nested function
    import me.sl.creator.mods.setmaskenable
    import me.types.bool.not
    import me.types.bool.toEnable
    
    setmaskenable('Length','enable',not(toEnable(startsWith(bvar,'Float'))));
end

%% BLOCK SUBTYPE VARIANT
function setvar() % nested function
    import me.sl.creator.inspect.blockhandle
    import me.sl.creator.inspect.blockfullpath
    
    % handle variant subsystem: VariantSpecifier
    vblk = blockfullpath(opts.blockhandle);
    vhdl = blockhandle([vblk '/' 'VariantSpecifier']);
    
    if startsWith(bvar,'Float')
        set(vhdl,'OverrideUsingVariant','VariantSpecifierPassThrough');
    elseif startsWith(bvar,'Signed')
        set(vhdl,'OverrideUsingVariant','VariantSpecifierSigned');
    else
        set(vhdl,'OverrideUsingVariant','VariantSpecifierUnsigned');
    end
end

%% MASK DISPLAY
function setdisp() % nested function
    mdstr = '';
    % output data type in angle brackets or empty
    if startsWith(type,'Inherit')
        mdtype = '';
    else
        mdtype = sprintf('<%s>',type);
    end
    % alias of mask type
    if startsWith(get(opts.blockhandle,'MaskType'),'DataPack')
        mdtype = sprintf('pack%s',mdtype);
    else
        mdtype = sprintf('unpack%s',mdtype);
    end
    % build mask display string
    mdstr = sprintf('%s%s\n',mdstr,sprintf("disp('%s');",mdtype));
    
    set(opts.blockhandle,'MaskDisplay',mdstr);
end
end
