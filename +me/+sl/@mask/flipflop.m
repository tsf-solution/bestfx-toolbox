function flipflop(varargin)

%% PREPROCESSING

% import third parties
import me.sl.utils.geteval
import me.sl.creator.mods.flipOutportTerminator

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

% get value of dialog parameters
bvar = geteval(opts.blockhandle,'BlockSubtypeVariant');
cdtn = geteval(opts.blockhandle,'InitialCondition');

switch(opts.clbk)
    case 'init'
        % validate value
        me.types.bool.validate(me.types.bool.toValue(cdtn));
        % attribute format string
        setafs();
        % hide/show ports
        flipOutportTerminator('NegatedStateSourcePort','!Q',...
            'blockhandle',opts.blockhandle,'portposition',2);
        flipOutportTerminator('StateSourcePort','Q',...
            'blockhandle',opts.blockhandle,'portposition',1);
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
    
    import me.types.bool.toValue
    import me.types.bool.toString
    
    afstr = '';
    % variant
    afstr = sprintf('%s%s\n',afstr,'%<BlockSubtypeVariant>');
    %initial condition
    if toValue(cdtn)
        afstr = sprintf('%sIC: %s\n',afstr,toString(cdtn));
    end
    
    set(opts.blockhandle,'AttributesFormatString',afstr);
end

%% BLOCK SUBTYPE VARIANT
function setvar() % nested function
    import me.sl.creator.inspect.blockhandle
    import me.sl.creator.inspect.blockfullpath
    
    % handle variant subsystem: VariantType
    vblk = blockfullpath(opts.blockhandle);
    vhdl = blockhandle([vblk '/' 'VariantType']);
    
    if contains(bvar,'S-R')
        set(vhdl,'OverrideUsingVariant','VariantTypeS-R');
    elseif contains(bvar,'R-S')
        set(vhdl,'OverrideUsingVariant','VariantTypeR-S');
    else
        error('no valid type selected in block ''%s''',vblk);
    end
end

%% MASK DISPLAY
function setdisp() % nested function
    mdstr = '';
    % mark dominant inport
    mdstr = sprintf('%s%s\n',mdstr,sprintf("color('green');"));
    if contains(bvar,'S-R')
        mdstr = sprintf('%s%s\n',mdstr,sprintf("port_label('input', 1, '%s');",'_'));
    elseif contains(bvar,'R-S')
        mdstr = sprintf('%s%s\n',mdstr,sprintf("port_label('input', 2, '%s');",'_'));
    end
    
    set(opts.blockhandle,'MaskDisplay',mdstr);
end
end